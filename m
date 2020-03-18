Return-Path: <SRS0=4fFE=5D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9125EC10DCE
	for <linux-block@archiver.kernel.org>; Wed, 18 Mar 2020 14:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613BC20714
	for <linux-block@archiver.kernel.org>; Wed, 18 Mar 2020 14:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CiKnn+gT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCROsy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:48:54 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55582 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgCROsx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Mar 2020 10:48:53 -0400
Received: by mail-pj1-f65.google.com with SMTP id mj6so1434904pjb.5
        for <linux-block@vger.kernel.org>; Wed, 18 Mar 2020 07:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2uiDaHt2g+JW3RjqNOfUWJ+R8BimazkfN7UnpCYPt8k=;
        b=CiKnn+gT0YykWDy50Gu2hVHEx7vxeBwXlnjrgL1mhukSGr51ZZVcztl/PHh/SoqW7j
         TO+pWvGqU4yCcqlQU+A/o78F1QjyM3sSoA6xAYExssFEl1TbjoiLSBWKBuBTrc5/n+Ht
         rpoG6dC0G/oDL2QOKFY84z66m6b2YSyacLueJXzkWQZa8b5+3H6oR3PDESfA5Y+Fuctx
         yvdDhmIPsUpEAMm1aB1+NdOs/zxnc2cSzqAYYZ1GSqFPhpxBVTGi+AVPfwcoQknZWrgo
         lLFmwHXNr/KfIdZNi4M/lDLTf+MOm4u+YQUAFIEovddTIsCCGO/pW8+wn2pwAqstQOTy
         hFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2uiDaHt2g+JW3RjqNOfUWJ+R8BimazkfN7UnpCYPt8k=;
        b=FmQ7ITV8IrEIzK3KaGbLARyxTbCA71DE2hSQyJRjAW3jdomv/sLeyWJ8j685dtfsnA
         LaWewAj3cPggnQWnjNAjoK+GkfOn0SNnU+b50OWoBSBpeHPC5vtKtwEt1zx7Q0RE3zca
         44wsQQPN6m8WAB2T4iTgtL39lNITZvGsC9wyebal108opNkmVKEjTj7Ou16jJ14kPukX
         K3cUcVjcxPvalSoB/uakYCvWfMN7oRueGPnHDR5Vk+grrokkOO3jFpOPsyTmN4K/1j5O
         jevsheNG8GmHZxBOuvKP7mxsCgh/5Jn4mepZt6Vu/pUKjbstJoUgubmeN7fJMovs8TFe
         2SAA==
X-Gm-Message-State: ANhLgQ2RpaqveGvnEM9dUCEyVur2/MYvSOLSWrcC73iMl1lrdLImkqRO
        Vc7vp7wdRaN6soEp16Zd5nJSmw==
X-Google-Smtp-Source: ADFU+vtV/3DJrhJT0ViE4zEanqJYY35vB+XM9UqjK3rin+kdp0QtjufxDrF8E0LqEapaAtOWsj71Pw==
X-Received: by 2002:a17:902:8543:: with SMTP id d3mr744922plo.314.1584542932249;
        Wed, 18 Mar 2020 07:48:52 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id a75sm2718121pje.31.2020.03.18.07.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 07:48:51 -0700 (PDT)
Subject: Re: [PATCH V2] block: Prevent hung_check firing during long sync IO
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Salman Qazi <sqazi@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20200318034336.6212-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3588c35d-3d16-7f5c-03fe-4a469a887342@kernel.dk>
Date:   Wed, 18 Mar 2020 08:48:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200318034336.6212-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/17/20 9:43 PM, Ming Lei wrote:
> submit_bio_wait() can be called from ioctl(BLKSECDISCARD), which
> may take long time to complete, as Salman mentioned, 4K BLKSECDISCARD
> takes up to 100 second on some devices. Also any block I/O operation
> that occurs after the BLKSECDISCARD is submitted will also potentially
> be affected by the hung task timeouts.
> 
> Another report is that task hang can be observed when running mkfs
> over raid10 which takes a small max discard sectors limit because
> of chunk size.
> 
> So prevent hung_check from firing by taking same approach used
> in blk_execute_rq(), and the wake-up interval is set as half the
> hung_check timer period, which keeps overhead low enough.

Applied, thanks.

We have two of these similar constructs now in block alone, I wonder
if there are others in other sub-systems. Might make sense to make
this a generic helper at some point.

-- 
Jens Axboe

