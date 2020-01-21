Return-Path: <SRS0=2A/1=3K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41502C2D0CE
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 14:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C947217F4
	for <linux-block@archiver.kernel.org>; Tue, 21 Jan 2020 14:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="U0aT5pb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgAUOJ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jan 2020 09:09:29 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44861 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbgAUOJ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jan 2020 09:09:29 -0500
Received: by mail-qk1-f196.google.com with SMTP id v195so2604963qkb.11
        for <linux-block@vger.kernel.org>; Tue, 21 Jan 2020 06:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MXMAlZrf6RWqgu1sZHLz9u+/Sa6aM/FrrOMx7Y5CS+U=;
        b=U0aT5pb5FoHZj5lISYTKH5SvegT1CwAlwWnXDVcU6MVD4WJMBL4/fWmH1qaQ2YSwUV
         eUXDAKu0ADfvrB0kuVG3ZhJ0AFq553As9ukd2UrMxzPtIK+LiURUpvHSl4wYJIKZLBZ5
         WMwphxiW4auh9oesjHPDimGLxo8R9n5B0fbppZnIpAFIXoR3uJjUew7y4/89ys4+beRZ
         QkR7UWQNR0zBXPk/LXNixzs7s7gxbAsWgNl9mMzREHTzbL9lrXbV8PbBvAg1vqP4sr8/
         fiTKtismOtboFx20pNHqT6F4HVs5/5aEcnHto8mWtBPrHQfh/bp8eMbnR7b94ejl/g3z
         KTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MXMAlZrf6RWqgu1sZHLz9u+/Sa6aM/FrrOMx7Y5CS+U=;
        b=noEftTc7ZkK9x6t8fw69yRsDHMYLDBiWSGAOePRevu5HDediYq0zZNjwUXkUyOfDOu
         h8TZelQHw7TzUkaku8zUXlurtEw5YqozlEoSpygr5vfpY/gu166PR3R/a3CIJqc03PIU
         WbRwgO5hhRjsY/lMry6l+xgj7T/DYRyRPNLudVoOsnOwmlMTe/OEDr3D7GjjW5SZg73l
         SZlv1MT/9WoYZyBkDli4fnlZoIjAEQlXLJS7+XvBn18R6aahIYskNnl1KIGegHTT67IF
         WdSSbjcuAFEdBtxaOWfroL+Ld3aKUgOeBeoAaN2PIhB/+QrH055zqTD4b+PtPIaKeJnz
         Hj8Q==
X-Gm-Message-State: APjAAAV5iXinHk7N41NeR9T4Q7yKruyjaeGZ3ooAOOdevATTJ6m8IY+Y
        O1+hRECkayDgJgmPUVd6UpOg4Q==
X-Google-Smtp-Source: APXvYqzbepHCf8odvOuFZORhg4stdqBChkK/lRhRxCuHcOGffbvJ/jV9yysnaPWYPxVgZaBof9w8Sw==
X-Received: by 2002:a37:b783:: with SMTP id h125mr4507737qkf.75.1579615768137;
        Tue, 21 Jan 2020 06:09:28 -0800 (PST)
Received: from ?IPv6:2620:10d:c0a8:1102:ce0:3629:8daa:1271? ([2620:10d:c091:480::822a])
        by smtp.gmail.com with ESMTPSA id r28sm19712087qtr.3.2020.01.21.06.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 06:09:27 -0800 (PST)
Subject: Re: [v2] nbd: fix potential NULL pointer fault in nbd_genl_disconnect
To:     Sun Ke <sunke32@huawei.com>, axboe@kernel.dk, mchristi@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <20200120124549.27648-1-sunke32@huawei.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8bb961fe-3412-9c3c-ad9b-54d446e90bf0@toxicpanda.com>
Date:   Tue, 21 Jan 2020 09:09:26 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200120124549.27648-1-sunke32@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/20/20 7:45 AM, Sun Ke wrote:
> Open /dev/nbdX first, the config_refs will be 1 and
> the pointers in nbd_device are still null. Disconnect
> /dev/nbdX, then reference a null recv_workq. The
> protection by config_refs in nbd_genl_disconnect is useless.
> 
> To fix it, just add a check for a non null task_recv in
> nbd_genl_disconnect.
> 
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---
> v1 -> v2:
> 
> add an omitted mutex_unlock.
> ---
>   drivers/block/nbd.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index b4607dd96185..668bc9cb92ed 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -2008,6 +2008,10 @@ static int nbd_genl_disconnect(struct sk_buff *skb, struct genl_info *info)
>   		       index);
>   		return -EINVAL;
>   	}
> +	if (!nbd->task_recv) {
> +		mutex_unlock(&nbd_index_mutex);
> +		return -EINVAL;
> +	}
>   	if (!refcount_inc_not_zero(&nbd->refs)) {
>   		mutex_unlock(&nbd_index_mutex);
>   		printk(KERN_ERR "nbd: device at index %d is going down\n",
> 

This doesn't even really protect us, we need to have the nbd->config_lock held 
here to make sure it's ok.  The IOCTL path is safe because it creates the device 
on open so it's sure to exist by the time we get to the disconnect, we don't 
have that for genl_disconnect.  So I'd add the config_mutex before getting the 
config_ref, and then do the check, something like

mutex_lock(&nbd->config_lock);
if (!refcount_inc_not_zero(&nbd->refs)) {
}
if (!nbd->recv_workq) {
}
mutex_unlock(&nbd->config_lock);

Thanks,

Josef
