Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F049C433B4
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 20:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A86061396
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 20:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241868AbhDZUJT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 16:09:19 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:35583 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241831AbhDZUJQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 16:09:16 -0400
Received: by mail-pl1-f173.google.com with SMTP id e9so12582754plj.2;
        Mon, 26 Apr 2021 13:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hyk3lvkrPdI5SNyvZXdyJdqKQ+8w1wWQadJx7Y3qHPg=;
        b=qt66dBkhxI1p7yZrbe8Uz//4XsxdITGIgQYWV2MHcp5RbIlg7c/L8i0k+FDyHCJr86
         3wJByVOC+EFxrVTc9uZz/v+LwXk1AMhMY7V+OImJOg2tbdlkZBPQwGNnYjMIbSIA2FOT
         6AiRgy2X5y4Xe8Znp1TztdQqO/FhdfhccvoTaYNu5NRRfyK/fOKb7JqFQHPN4EQChlFH
         EvZY12SVwgorG/OdhCiNSqIW2MTfgxkNyZX40DfwUIVQVF84wEukJJLIPOeoRgFfbNIu
         vIV/JJWF/n+jYQOSkUHNPA6n6peDEKCllz1wlh1gbnf+2xW6Bn/Vr28yNoVAyxM7fPPn
         INXg==
X-Gm-Message-State: AOAM531yA6MtoLs47S0GxeUf1uRw8uHKwCtHQhd25JpilN+D38pfGZMo
        Os9/u98Uro2Vm8WtrHQ0EnYdhpSKSgk3MQ==
X-Google-Smtp-Source: ABdhPJzBFD+vYRsnFCKO5TD2Wtp3X486CNfga2x3VSWLWTcdYdXxmwHbtvvm05DgceJVysoeiFNJ7w==
X-Received: by 2002:a17:902:ed42:b029:ec:a711:25c7 with SMTP id y2-20020a170902ed42b02900eca71125c7mr19925258plb.58.1619467713031;
        Mon, 26 Apr 2021 13:08:33 -0700 (PDT)
Received: from [192.168.50.110] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id f18sm442659pfc.196.2021.04.26.13.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 13:08:32 -0700 (PDT)
Subject: Re: [PATCH v2] block: fix userspace documentation reference for
 del_gendisk()
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk
Cc:     ming.lei@redhat.com, hch@infradead.org, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210426185040.24580-1-mcgrof@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <2a3d62fd-af5c-ff9b-00cf-3d32405d0daa@acm.org>
Date:   Mon, 26 Apr 2021 13:08:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210426185040.24580-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/26/21 11:50 AM, Luis Chamberlain wrote:
> Commit b5bd357cf8b ("block: add docs for gendisk / request_queue refcount
> helpers") has a typo where it references drivers for del_gendisk() when we
> instead meant userspace, as the reference is to the userspace experience.
> This fixes this.

Thanks!

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
