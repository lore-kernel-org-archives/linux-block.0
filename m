Return-Path: <SRS0=61bd=TH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80345C004C9
	for <linux-block@archiver.kernel.org>; Tue,  7 May 2019 10:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D9EB206A3
	for <linux-block@archiver.kernel.org>; Tue,  7 May 2019 10:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/JigDTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEGKXF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 May 2019 06:23:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38921 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfEGKXF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 May 2019 06:23:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id z26so8426350pfg.6
        for <linux-block@vger.kernel.org>; Tue, 07 May 2019 03:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sr8Pz03FlEmfvEi/csUsOrKUnpi3Nc1BLYoKmGePRQM=;
        b=K/JigDTOgHv5pDz57smlET+A3p50bnG59DEBHDpEHK9VOs0eNt+nvvkdIvOecZ6gXa
         0sJphsF16IXtn+Edi+dxIIRbVhojafQhkNi8YG49cgRJsLduQyIUJyyy6YOjX3YcXUtF
         Li6RbPxv0mQDMG3cbL8udc2QIdrutxBWmv/0+6q9QqySZED/4BRAwcp7XKsyBunKJjZi
         Fs5L+Jj+ppsnaHvrYs0NyL4T8ke0+svcfb0YzHdFLBiYugMVhqoQZfgZ4DY2DOeVp/cJ
         nFDg5ioFQIrRNF9ELlrTPikAnR1nUgizcBE9EOe3pLGJRxy998F07S9e2clj4E3WJyzw
         IaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sr8Pz03FlEmfvEi/csUsOrKUnpi3Nc1BLYoKmGePRQM=;
        b=OI53gw+6VjFYmQ7OaK72LwJpUEYTmrXpE/2dqas7vd2XtNIDcasl5fcjO6fkxIlcn4
         JgcvCDeokZg2HzUncqX5cw/ZsC/RLoBjKHRXNDwbW072RszG/BcNLYfyGCwDW35upzcS
         PASY+W1e7fYhnBvLY3NmdHB8HNS2I/48fOLNfX64/+JhfDLCoea3AN9ta1i3ybSG/9Kg
         HYA5wTR4XF1ZY3zizpEpEKZJqBHQgpMlJrF93ZPy85HmZ9wO3X13q2Gf4LRv45WH5ebJ
         dLzQ6cu2xbPCLYKDu8jnCcjRIu8g6zWzVCp0GQlySFREhcBHIsgf+G2fzzwKlk6bAxlY
         j81g==
X-Gm-Message-State: APjAAAXwgaOhcOHvDrowK/Ta8ktxTkE7tUVU1s76yBuEv9AaZkpAF+JJ
        IgDmoiyfeApCSgSZcXulIOY=
X-Google-Smtp-Source: APXvYqx+MgsFKuY6OrZ0SX15hfRQNeGA4XSvHi/LQExTr7sYlDP1dZwnLzwQnpIth3DJPk5nkRwdIw==
X-Received: by 2002:a62:69c2:: with SMTP id e185mr40105392pfc.119.1557224584744;
        Tue, 07 May 2019 03:23:04 -0700 (PDT)
Received: from [192.168.0.6] ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id i129sm16548715pfc.163.2019.05.07.03.23.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 03:23:03 -0700 (PDT)
Subject: Re: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Omar Sandoval <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-2-minwoo.im.dev@gmail.com>
 <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <a66b775f-9a5f-fefc-ae29-c86678e66463@gmail.com>
 <SN6PR04MB45272BEB18B3ADD95DCB42AE86300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <cfa4d48d-ce13-0ace-cf5c-a3d0d1f4cca7@gmail.com> <20190507062034.GA3748@x250>
From:   Minwoo Im <minwoo.im.dev@gmail.com>
Message-ID: <e118dbb7-51a5-d013-8c85-391452846411@gmail.com>
Date:   Tue, 7 May 2019 19:23:00 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190507062034.GA3748@x250>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/7/19 3:20 PM, Johannes Thumshirn wrote:
> On Tue, May 07, 2019 at 01:54:09AM +0900, Minwoo Im wrote:
>> If Johannes who wrote these tests agrees to not check output result from
>> nvme-cli, I'll get rid of them.
> 
> Yes agreed. In the beginning I though of validating the nvme-cli output but
> this would grow more and more filters, which makes it impractical.
> 

Cool, then I think I can update the pass condition of this testcase in 
other way.  Once Chaitanya gives his comment on this, I'll prepare it.

Thanks,
