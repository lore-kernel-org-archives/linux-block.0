Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E97C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D398920830
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 12:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="mXufZogJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfCDMkP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:40:15 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33541 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfCDMkP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 07:40:15 -0500
Received: by mail-ed1-f68.google.com with SMTP id c55so4132287edb.0
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 04:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lltpYnRaRvtQmVlD91I/ns1yfP/rAogZKKxztD3uq44=;
        b=mXufZogJSZzYGn6S7O2JlgIcIc5sOeyT5ShjlFJ9Uo6sIaHicB42fRmnxNl14AvYv6
         aNxN9cezVk0SVSqffp9zDtbyJCNLjgIwVLuOjCog3O/tFcQoxi1Fv2+kZ4h008NH0zwI
         P8fwYjYWE7O+fzx8Tr4nUV3eUcumaJyCJ5pFjGMMJCMCuQohPbjMZTdPDLi30h+O7sq2
         hmxj1PE2VImHvGu1ca+QXjzF6bWJqJw4Dl3KcgCovtQw/Hd/X8Gl9VZVW9YBPBL32iYO
         xd/hN3DVwEXrBXmqPgkYZIyoAu2qOCSgndkYjPWG3KvOM6PiRSUn2F39FSxMiNNmzgZ/
         Ni9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lltpYnRaRvtQmVlD91I/ns1yfP/rAogZKKxztD3uq44=;
        b=pxmRPdMMUT9G0koCNU4NxYshod6m8JKKE2bEJL/e83ZoTZFxczNal/cVe5QhXv3uhV
         N0KmdGhhHlaT7FWPcGrKAwuKl/uCkf9D6mxNrwDcIG2WkLk7axfpHIAPrTR1YJmp/1ky
         6V8vkG5EJpCLBpb5LdPRj4qkXTS3zWvemlus0SuC9YGSLOJAFeN7sTDvyNYobYvi2ZU2
         YhxMlEo+snP2zQgU67OVX3dhiOJl5Pn1DbeGparN0M20z7hTLlyPOx6VtdQmfA54sTT5
         /gGsHJ2UoqXMW5PQpy+FAtixfzktFmqbX7NwFAM22gAObcjrPOmdfP05akDHprAZX4EY
         S+EQ==
X-Gm-Message-State: APjAAAUT0Q7WAuMbm29GtLiVP/Sn2o9KAfQcYN+dlFLMGppBex2/sjwx
        0FnJaqz60isZGbEPsT/KoStgO4BiyWw=
X-Google-Smtp-Source: APXvYqwfeaQfNincFHpwHZFEWBiT8Rm5ItWuDi1bp8mLv2utuIVpSyRYT0F6PnqO+dTuA6tq6RBUvA==
X-Received: by 2002:a17:906:485:: with SMTP id f5mr7910670eja.85.1551703213011;
        Mon, 04 Mar 2019 04:40:13 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id w54sm2067475edw.82.2019.03.04.04.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 04:40:12 -0800 (PST)
Subject: Re: [PATCH 01/13] lightnvm: pblk: Line reference fix in GC
To:     Igor Konopko <igor.j.konopko@intel.com>, javier@javigon.com,
        hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-2-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <9cc0b1bc-d34b-c678-6db5-3b12848e80f9@lightnvm.io>
Date:   Mon, 4 Mar 2019 13:40:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190227171442.11853-2-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/27/19 6:14 PM, Igor Konopko wrote:
> This patch fixes the error case in GC when
> we both moves line back to closed state and
> release additional reference, what cause illegal
> transition from closed to free on pblk_line_put
> when only gc to free line state transition is
> allowed using that path.
> 
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>   drivers/lightnvm/pblk-gc.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index 2fa118c8eb71..3feadfd9418d 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -290,8 +290,11 @@ static void pblk_gc_line_prepare_ws(struct work_struct *work)
>   fail_free_ws:
>   	kfree(line_ws);
>   
> +	/* Line goes back to closed state, so we cannot release additional
> +	 * reference for line, since we do that only when we want to do
> +	 * gc to free line state transition.
> +	 */
>   	pblk_put_line_back(pblk, line);
> -	kref_put(&line->ref, pblk_line_put);
>   	atomic_dec(&gc->read_inflight_gc);
>   
>   	pblk_err(pblk, "failed to GC line %d\n", line->id);
> 

Thanks Igor. Applied for 5.2.
