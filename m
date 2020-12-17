Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736A0C4361B
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 13:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43840238EF
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 13:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgLQNaT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 08:30:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgLQNaT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 08:30:19 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAF3C061794
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 05:29:39 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cm17so28656856edb.4
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 05:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1BSY6kpvRH25aR6tgxXyew31N03tNmdGM4l7dDerG+8=;
        b=Ui2GhRBdHoQLhgzq3LaQMwyNM1FnyxlYOHoIV6Cz4vUequOcYmrsbCUWk1SLbJc6wt
         qyOyT8OXH8JYRpzF82Yh98yS9xSKQzNRqUP/kDoBLwTYPqONnh6ARLxxgWYCDZxmq8DM
         gU9QWFhqWmJdGPNmSdliiukFBHxcLGiZkUkys/TJx5LLMBBITYIHIfe+E4yB6gdmniNd
         dEtr2n7gH/7Bg0cyujXy/x6BkY2l2kVJE6PlpjhPRjEUrVXkETVebRMwCGtb7ujIh67i
         c+jyc9QaQaV/l9PGEGiAJn4bKpZMtClzf32X//G3cmD9CAzfFlTB8HizIdm2P9nPwmlI
         yGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1BSY6kpvRH25aR6tgxXyew31N03tNmdGM4l7dDerG+8=;
        b=fqq7aa39dms5inTBK5wqnsJXlJxZaSeAjntvMQ2GkHSpF6mye8IEjR3UyAd/pkBHD0
         rdpz+QfePulOmy6TG/2A1Wx/6hjpc+hY+TJdHK93kWl44r2FnBq83V1nBkUWRGUiqhns
         TDBS3u019SU7GQFk46DcsLclDcPvT/xQdShp7ENm/HJjUR5rCvB9zJE6QzjrPuizZ5+R
         oTAiQH8AVwuIRyG/1LQJ6Zg/Ajr07ytqisg0jF6K1jOQffp8QDxAjwKh/Y298ToBT3vo
         JaF7OZWBJcKgXctVRD90Sf0mwtiASTYM/R0U3TJECDjElA7nqSyNxEf9oDeWgpj4NrPg
         dnpQ==
X-Gm-Message-State: AOAM533Ek6OElvWfCqe1/Nwm6BuXuWqitHZ+ncF6A5gH95RAHTfSIDl3
        YiWRyKLgA68dEaKzgBk6PvLGqlw5nBTvUgpsbW8=
X-Google-Smtp-Source: ABdhPJxVeHu+AlfAuTrOx4tmtzB26fWL4M/0KwddBdphatLAru+U95pCunKDgeb625eQXQDR5CTNCA==
X-Received: by 2002:a50:e719:: with SMTP id a25mr1287074edn.12.1608211777885;
        Thu, 17 Dec 2020 05:29:37 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
        by smtp.gmail.com with ESMTPSA id l22sm3838719ejk.14.2020.12.17.05.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 05:29:36 -0800 (PST)
Date:   Thu, 17 Dec 2020 14:29:36 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        hch@lst.de, sagi@grimberg.me, minwoo.im.dev@gmail.com
Subject: Re: nvme: enable char device per namespace
Message-ID: <20201217132936.3wvuguclzwll5kqu@unifi>
References: <20201215224607.GB3915989@dhcp-10-100-145-180.wdc.com>
 <10318EDE-F4D0-4C89-B69D-3D5ACA4308C2@javigon.com>
 <20201216162631.GA77639@dhcp-10-100-145-180.wdc.com>
 <20201216174322.v2ahfdhvgix536gd@unifi>
 <20201216175311.GA31311@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201216175311.GA31311@redsun51.ssa.fujisawa.hgst.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 17.12.2020 02:53, Keith Busch wrote:
>On Wed, Dec 16, 2020 at 06:43:22PM +0100, Javier González wrote:
>> Thanks Keith. I will send a new version today.
>>
>> Regarding nvme-cli: what are your thoughts?
>
>I was thinking we could add a column for these with the '--verbose'
>option in the namespace section.

Makes sense. I will look into it - probably on the other side of
Christmas. Should give plenty of time since this till not be merged
until 5.12.

Should give me time to add multipath in a follow-up patch then.

