Return-Path: <SRS0=A22s=WX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15304C3A5A3
	for <linux-block@archiver.kernel.org>; Tue, 27 Aug 2019 16:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD79F2173E
	for <linux-block@archiver.kernel.org>; Tue, 27 Aug 2019 16:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730035AbfH0QiB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:38:01 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:44593 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfH0QiB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Aug 2019 12:38:01 -0400
Received: by mail-pl1-f171.google.com with SMTP id t14so12031524plr.11
        for <linux-block@vger.kernel.org>; Tue, 27 Aug 2019 09:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rGjhiT6dMpMoSrZXIUECRp6N3/WNZEug3kElTQ33hfk=;
        b=ATy0WgRrEbi/qxWb2sD5ZPgB9XhhLXUBn6mwboKl6gsT9t1vnIj2x/kjViAqn5Q7vo
         sChqk6uP60QWGtlpcgRa4sfHLEC1jy1/oY7Jqt91vh8/31hFo9OkD6MuLNwAho5n6nNd
         axp31pUXPoWY850Wj8o4xAgdL/Y8n+e7TQ0QAngHYnO5O3YuobaIwsznZq17ZR3bneE8
         Kp5FD7Wr/ZeqGe/ZOPVmEvMDi1tv/d+YjgQFb3FRrN7PUJGYJ0naIYlf4G3p0JH+BREP
         kgILqlXOoqkF0FsooggcPyrZxFQz6iGh1VxPC5IuLrM8l5J7d1b3PIsDt+PzZ6LPZLcK
         v8DA==
X-Gm-Message-State: APjAAAVjELsgBLTj7j+i7BoQgEHABDr7n9jzrL5HQYgkYrT/MuNWth/J
        uuV8Qrh26gKlz/6SqFmzQZ4=
X-Google-Smtp-Source: APXvYqzNMzekVFbt1whm3wg+h0wYiF5Rke9xZcLze4oG2JiULWjQBwuQkjIdKR1bynjlLRdth224pg==
X-Received: by 2002:a17:902:e9:: with SMTP id a96mr13475120pla.169.1566923880301;
        Tue, 27 Aug 2019 09:38:00 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id j6sm17036577pfg.158.2019.08.27.09.37.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2019 09:37:59 -0700 (PDT)
Subject: Re: [PATCH V4 5/5] block: split .sysfs_lock into two locks
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <20190827110148.808-1-ming.lei@redhat.com>
 <20190827110148.808-6-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7f0593f7-356c-6fef-f280-024c0ead9fcf@acm.org>
Date:   Tue, 27 Aug 2019 09:37:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827110148.808-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/27/19 4:01 AM, Ming Lei wrote:
> The kernfs built-in lock of 'kn->count' is held in sysfs .show/.store
> path. Meantime, inside block's .show/.store callback, q->sysfs_lock is
> required.
 > [ ... ]

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
