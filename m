Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E451DC43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 21:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42DA218FE
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 21:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YUEVu15A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbeLTVAG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 16:00:06 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:34566 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbeLTVAF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 16:00:05 -0500
Received: by mail-io1-f48.google.com with SMTP id l22so3748ioh.1
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 13:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sqtC2uGo7nMUeVT1P25XCmQZgqBw4h0SWsG45fyF4So=;
        b=YUEVu15A/ktcs+qt0CQLdwJNCHKXgpm6rpZ1abHSNj/Z9Lgg8SsBHvkte4/bfKY7Ld
         L0+w4FmiGylH0biwRwQi2QLhELz5gJOZuw8E14JAup1UtkBXkwevpDUvJwC9/OwZm2V9
         yexmCj2zQTcZpZ8mSY2okSYFVDEqE+jux9M27j9ig7kS+MCzF/h2xtkALQdowC1FKa6U
         VL0xwZehpmMYQuuxWT4msXxfZ8QrLgvnFMVTr0arXWGDmj5mb5L9uFaIAdw07OxjXFmv
         rjkwQbdJLhHW1CG2TPgvz8zxZyt//hASMr1tuzMYDVs+2S0/86OZs51qOk2Cc3FexXij
         AEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sqtC2uGo7nMUeVT1P25XCmQZgqBw4h0SWsG45fyF4So=;
        b=jlW/szxVEZmU/zNqt7iSe/o8C5gwAoEXOHOffck0FjBb6i3KfQBYs+hMUxkCn/VuGx
         C/MqKXlaH38f68rTZebqTDTsR/PamcTICQOkqWH2ULhszoPGldJzKGZZreczpblaZAmn
         qKfK8gQKsYW/9CPnZec8aTYEBYTetCHQ301EXTvLhR9jv5r4Yr+NQbS49OFDfSAEhWxH
         sIYiW0wFUxD/PMRmeqkuYb0g7vi5ju0oFPT6/Y6dGEr/cQzWdiRL9iOKx1IWX36+F/Q/
         MGwufDCPtM0K4He447M+VzoVKN/OJXLmfGErxw1Q3BQy3vFZr2Mnh0JdLI04gDaZ78jE
         KcNg==
X-Gm-Message-State: AJcUukeaWzd9qeZHNRQFrj31MLlO+wSXeBeU9wzj8F3d3n8Y1BdUI1TJ
        zTtJ22aOyHR2ZR4eO6hD5U7oQdi/ugsU8A==
X-Google-Smtp-Source: ALg8bN5NunyLIqdIL2QshvX2P9UQLHKLvlyeRD4b7GZvz3qghGo1flZq49MbLQ9Sw+GQQXfncrm3TA==
X-Received: by 2002:a5d:83c4:: with SMTP id u4mr5713052ior.213.1545339604392;
        Thu, 20 Dec 2018 13:00:04 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t2sm10789283iob.7.2018.12.20.13.00.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 13:00:03 -0800 (PST)
Subject: Re: v4.20-rc6: Sporadic use-after-free in bt_iter()
To:     Bart Van Assche <bvanassche@acm.org>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1545261885.185366.488.camel@acm.org>
 <74c0280c-e557-ad03-cd75-98dd6d868da3@kernel.dk>
 <1545265001.185366.496.camel@acm.org>
 <1ca5cd37-87ce-8cff-6cb4-1fdb29bd4da2@kernel.dk>
 <0560802f-efc0-e9ec-99f7-4bdbdbc234f8@oracle.com>
 <c078750c-ff6b-4939-281b-7556d31dc74d@kernel.dk>
 <fe9dfe60-3cfc-9cfa-56c3-1365cbe8ec53@oracle.com>
 <a45c9931-ce8b-0ac8-f304-412c6042eff9@kernel.dk>
 <372d2960-ff0c-1135-28f9-23eea8670463@oracle.com>
 <ccf50ee5-ff34-39a0-d7eb-3853fee55a4c@kernel.dk>
 <6ae35005-7ba9-91e1-f315-d128f410c12c@kernel.dk>
 <1545328865.185366.508.camel@acm.org>
 <bd78b521-d0d4-22ec-ff7f-2d70709ca742@kernel.dk>
 <b9c3bd7c-9e82-7300-d525-0bd72ed66f66@kernel.dk>
 <1545339362.185366.511.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e7d6d857-b20a-245c-c6c7-fb9b110215e9@kernel.dk>
Date:   Thu, 20 Dec 2018 14:00:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1545339362.185366.511.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/20/18 1:56 PM, Bart Van Assche wrote:
> @@ -96,6 +97,9 @@ static void blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
>  {
>  	struct mq_inflight *mi = priv;
>  
> +	if (rq->q != mi->q)
> +		return;
> +

Aren't you back to square one with this one, if the tags are shared? You
can't dereference it before you know it matches.


-- 
Jens Axboe

