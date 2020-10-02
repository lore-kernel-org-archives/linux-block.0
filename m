Return-Path: <SRS0=oVJv=DJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05464C46466
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 23:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B62FA206B6
	for <linux-block@archiver.kernel.org>; Fri,  2 Oct 2020 23:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="F8kEaJT/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgJBXxJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Oct 2020 19:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgJBXxI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Oct 2020 19:53:08 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67406C0613E3
        for <linux-block@vger.kernel.org>; Fri,  2 Oct 2020 16:53:07 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j8so178442pjy.5
        for <linux-block@vger.kernel.org>; Fri, 02 Oct 2020 16:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Krm4cUinP2ZnHJMcjdvF7+aHcAqaVid7ubHsX5Hx6MY=;
        b=F8kEaJT/81zeRpObqHKzAKAvppEK+jcl3ylqEDHTytBMJo76fgLBX8NRXflEseeuHZ
         0DwxqRnBRhWQn2QB2RxCN3fLYu/6NY4az/an9l7DPNv713X7P3OrSDl67v03+yuahavt
         5OvO8PPkWQug0t/mx8HKbhqbpmfT/3NkKB713jRTvhgdfI8yF6WGqAyR0LUu6r/5Qm8P
         QY6H/C357hZ+V+z1tzNa6rNrqOcXams0qRkOK2R2YzSR1nBGc8kd1awLxDQBe5oD0HBE
         iTYA37R1RL8kKqwTVAugNm1CZV5FDh1+VSMKuBjSTYHm+TUn3hfNj1C+I4AmJ7o9NVFy
         oVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Krm4cUinP2ZnHJMcjdvF7+aHcAqaVid7ubHsX5Hx6MY=;
        b=XYvG5q7VbACxTBN3t43ToUnVARy1BSL/jYXtqsI6MNcuxCn+R4tFX8h0ElaWqHjBhu
         IzCvwz1ihxJc/S+7tvAx0kmJGCMsvE6Gfd/uXWdoMGAyLzunxL9hfnR30ds+zGbKXrxT
         yZZwpBU6LTXhKS/97nSIcEQPibWtTesAxUoWutbLDJnbS85djsJxw9tPBRTq3Q3dBpnc
         hqP7cTC3Hr4Gj5oMLFv2aN69bJa2mZVw9wnz/C+gvmIgK+SyU4ovI/p4bj+NQmyFzb2A
         U5kZNotzfqOopX6Ps15odYblW6ldPfWTWDIOk2Si+lP42AIywP5uBi3FRNCjDDmxJdSp
         FQVQ==
X-Gm-Message-State: AOAM533FlZqrXpS+YBCtuuYlzCRTA8TNqIL/sn4s705hBMyrf0Dmme1o
        HXJ/QeASVkO13+64knNtDbvzBh++F1fLdO2X
X-Google-Smtp-Source: ABdhPJydymlGPn7Pk4GNnWGcQav4MOnf+52DlXw05JAhewlJ+3pLJqRd4lFQqGABkUFFASN0QjcPuQ==
X-Received: by 2002:a17:90a:6705:: with SMTP id n5mr5190620pjj.72.1601682786821;
        Fri, 02 Oct 2020 16:53:06 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id k7sm2652424pjs.9.2020.10.02.16.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 16:53:06 -0700 (PDT)
Subject: Re: [PATCH][next] block: scsi_ioctl: Avoid the use of one-element
 arrays
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
References: <20201002231033.GA6273@embeddedor>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ea92a55b-d12c-357e-62b2-879643ae18ce@kernel.dk>
Date:   Fri, 2 Oct 2020 17:53:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002231033.GA6273@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/2/20 5:10 PM, Gustavo A. R. Silva wrote:
> diff --git a/include/uapi/linux/cdrom.h b/include/uapi/linux/cdrom.h
> index 2817230148fd..6c34f6e2f1f7 100644
> --- a/include/uapi/linux/cdrom.h
> +++ b/include/uapi/linux/cdrom.h
> @@ -289,7 +289,10 @@ struct cdrom_generic_command
>  	unsigned char		data_direction;
>  	int			quiet;
>  	int			timeout;
> -	void			__user *reserved[1];	/* unused, actually */
> +	union {
> +		void		__user *reserved[1];	/* unused, actually */
> +		void            __user *unused;
> +	};

What's the point of this union, why not just turn it into

	void *			__user *unused;

?

-- 
Jens Axboe

