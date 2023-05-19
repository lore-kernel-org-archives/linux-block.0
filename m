Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8BFC77B73
	for <linux-block@archiver.kernel.org>; Fri, 19 May 2023 02:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjESC1v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 22:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjESC1v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 22:27:51 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C1C186
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 19:27:50 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d28c9696cso219116b3a.1
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 19:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684463269; x=1687055269;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bi4CaIiTRmDOwJi9Ptec+oZcPqUeCGJR0VjniBUQwWg=;
        b=Uf8CoVi382Dr7NiBQz/N1kxQU5eIPe/QxQoHUlHVUNbwpgkIGAtRl2nEEMUmCViwL/
         URD5EmU+oKzAln6Xh5Qr4VyIdwmuGrUpz9QUG2iECNRBTetCJo52YeD4O5vCUKsJuMSc
         2QhP0xM9BJitcp0LOhXeufW+HjRLMul08GH/wb6Z2us6lhzGEJlUyKTSpLqOPqDO630i
         kkHIFCWgCT4M6DK7z/l8u8b2ZsqorJraw841kM1KNaA8Xsye9LXO6MVwLi654geXxV9S
         CtmMHU4xvCm4bJGSyP+wj+TBuAkUgjbkxdg2tKgG7hDRLIPyJafLJvsISto9XxRRvu8J
         fDwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684463269; x=1687055269;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bi4CaIiTRmDOwJi9Ptec+oZcPqUeCGJR0VjniBUQwWg=;
        b=LeqYzjr07LvBR2+t2wrbhPiaUwL1c/rl7Tuv/JRCpoEVFKdYCa/CLTp5PGKqqVNR6d
         HndDSZ5HN/CmbkoDfD2Fiozj+3KLyYGAgLpVVx9Ma7HcktU0ImZXtlvkhUccJSOayVCw
         Ues+4aC5txZm0BnTEt7cYGoNJryW9wbzgW7F6JgMi3+q3xhR5RyaBYqBnKEFgAhqmtkG
         Huq2EHdcTDY8EdIlBj1ntYuUybJHIb0B5GmJLfNNcnwdHmL34KeMM3HeBnwkvwjDNCnQ
         Ag+drdTY9GG8WjEOlNYQNcZNL1fhYVLuJvPlnosOHJpCjltyiEdaEsvuJ0z0AsrBv2dB
         YLBg==
X-Gm-Message-State: AC+VfDzACYanIFvEcpTry0/Z7AXeUx46PfTE0sfJbP2NmImCl4gJLzyv
        lZLDqfc0MQis8oLMWHsQyX4VEQ==
X-Google-Smtp-Source: ACHHUZ4JP5imTCUXblgyFujCoTTjoFD5B5oxWyW3GmXnLuBhBzlQb065maM018D/wGWOZ3BeXaowug==
X-Received: by 2002:a05:6a20:7fa3:b0:106:4e09:153b with SMTP id d35-20020a056a207fa300b001064e09153bmr484904pzj.6.1684463269649;
        Thu, 18 May 2023 19:27:49 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x23-20020aa784d7000000b0064867dc8719sm566487pfn.118.2023.05.18.19.27.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 19:27:48 -0700 (PDT)
Message-ID: <16569acf-8822-3bc7-f242-f9cf4e992c83@kernel.dk>
Date:   Thu, 18 May 2023 20:27:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: rationalize the flow in bio_add_page and friends
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jinyoung Choi <j-young.choi@samsung.com>,
        linux-block@vger.kernel.org
References: <20230512133901.1053543-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230512133901.1053543-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/23 7:38 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> when reviewing v2 of Jinyoung's "Change the integrity configuration
> method in block" series I noticed that someone made a complete mess of
> the bio_add_page flow, so this untangles this to make the code better
> reusable for adding integrity payloads.  (I'll also have a word with
> younger me when I get the chance about this..)
> 
> Diffstat:
>  bio.c |  123 ++++++++++++++++++++++++++++--------------------------------------
>  1 file changed, 53 insertions(+), 70 deletions(-)

Nice cleanups and generated code reduction too.

-- 
Jens Axboe


