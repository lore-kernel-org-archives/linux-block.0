Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB16C04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A7C20851
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A7C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbeLDBj0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:39:26 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42228 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeLDBj0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 20:39:26 -0500
Received: by mail-oi1-f193.google.com with SMTP id w13so12842337oiw.9
        for <linux-block@vger.kernel.org>; Mon, 03 Dec 2018 17:39:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=A4/Wp2PhtnQxrSIuRtYMnf3r75EKB8y/yAWONEXvvO5hlwzu7s/YdebG+ERIvvWlrD
         3gUcG99JgE7m3zP2NBm66l+SOevkQXhy3lj5U+feMD67gwETanAKxWxdDxJbH3D27nNX
         vMkai4I92iF1rAzHHBw/mM31XV+t1kdkP1CQG+VOBJkMRN7N47TDv1bqlExYvndVDNx8
         F72+/yKCEMnEHb940KgbgXhB1GNKT/NC+Hmsu7CoF0og3lRh3QTh6YoQhrfrMfWPlARL
         zT1SqDkQ5cC+XDMMz/a7DTely+CeMnJZyVmM3ZlBQHbeFHGiW+mu3j3Z8xPh1TZ5iQcI
         xhJA==
X-Gm-Message-State: AA+aEWZ8uekjo8yWbDyeOuBsBqKWNYoAu503GTybRtIYWMlayBB+V3qD
        TZz454JE+DddrizivGGPNMo=
X-Google-Smtp-Source: AFSGD/XmaL3va3MSaLBHu77P+U/83yzDNPahlrh6B8X74t8NSrRA6hbafln9NUTMLMyZNd5Hh2OWdg==
X-Received: by 2002:a05:6808:34e:: with SMTP id j14mr4336457oie.32.1543887565903;
        Mon, 03 Dec 2018 17:39:25 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id x92sm8449853ota.55.2018.12.03.17.39.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 17:39:25 -0800 (PST)
Subject: Re: [PATCH 6/7] blk-mq: use bd->last == true for list inserts
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-7-axboe@kernel.dk>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <05220c91-1f29-7ad8-0658-5775c893946d@grimberg.me>
Date:   Mon, 3 Dec 2018 17:39:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128133538.20329-7-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
