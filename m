Return-Path: <SRS0=6fCZ=WQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ABEC3A589
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 21:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619B82332B
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 21:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbfHTVHq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Aug 2019 17:07:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43451 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730851AbfHTVHq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Aug 2019 17:07:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3so2857pgb.10
        for <linux-block@vger.kernel.org>; Tue, 20 Aug 2019 14:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qj9uH3CPM2KrfX2VIgBstTyG4ls706vPJZSXFjT8TzI=;
        b=COeVFBqDcf1bwx5pElZGVXZHD1fVrf0TNfcS0ECVehib7C7opogphNApQy71pkyrAn
         INjJw+Q0YgQMaEayPqNT2h94u5i79EFlLkBJ/Z2FsCqVo+u8MRWAHlIpt28IdhWoCqrB
         kzWReo+X1eEV47RS8dIbbYX19i8dLAcB8vxxnq6ZOXVkQZy7VVHO/izBLWBNts2EBJaZ
         IisETxgJTaHmoc5klPC6JYKapQR8Km7EJmf6UV9ZWk5rYTxwoGXcq/QePUvvfF2QWbNl
         /RmQ9YZM12ZGBP6043PkSJbfRC02ojeBqc8lq4IpSvgeFbB+9o1xarPVjsJ61M47aqUx
         hBWA==
X-Gm-Message-State: APjAAAUf6Gv/aA6EX7RUsaP4qIRQh9+jmBo18NRD/Hnl8vUMhVv7XMkM
        cbgF178AfANpbhVmgww4M8U=
X-Google-Smtp-Source: APXvYqxQMDhUAjCfS9e5+UYmm8ZzKiwVLKe3+AECNxxmVdXbXKxUhQDaJu/dcTGQEl2hu8Ls93P/HQ==
X-Received: by 2002:a17:90a:ac11:: with SMTP id o17mr1955843pjq.104.1566335265720;
        Tue, 20 Aug 2019 14:07:45 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id ce7sm800983pjb.16.2019.08.20.14.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 14:07:44 -0700 (PDT)
Subject: Re: [PATCH] block: don't acquire .sysfs_lock before removing mq &
 iosched kobjects
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <20190816135506.29253-1-ming.lei@redhat.com>
 <429c8ae2-894a-1eb2-83d3-95703d1573cf@acm.org>
 <20190819081536.GA9852@ming.t460p>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b79a9f96-f085-1888-bd10-d6dc72aba30b@acm.org>
Date:   Tue, 20 Aug 2019 14:07:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819081536.GA9852@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/19/19 1:15 AM, Ming Lei wrote:
> hctx->tags is tagset wide or host-wide, which is protected by set->tag_list_lock.

Isn't the purpose of set->tag_list_lock to protect set->tag_list?

Bart.
