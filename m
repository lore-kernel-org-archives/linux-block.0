Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EE8C54FCF
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 23:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2946E206C3
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 23:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TEBFfXqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgCWXJ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 19:09:26 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33323 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgCWXJ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 19:09:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id g18so6598887plq.0
        for <linux-block@vger.kernel.org>; Mon, 23 Mar 2020 16:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=srDYPq1sl5XiMrVTRNik2lXd48dAxRC5F99gwAgQsHo=;
        b=TEBFfXqZEMVAhTNH1rt7KDfVJOmBeB4x1ad9Sr9wUA2OJU8VdPPHOo7NyMQGJF8n3H
         ++fInsswuB8sYGavE7diMFgQLvKFXPgFqbd3msrORoFlkPSJXtCrQ5LU2HG7x1G6bg3A
         oZ3kwVg/WukNP+TvlYf8IxocWp7AlIIrto74UjojiJz4kjNR0N/v86lnnQd5FnOmeC5N
         WTpAfK7dIrwLJPrtujYM4ajAvtp+m20xhyx71z0O4toKPw+7Lq/RUcmw5IrJbNomxaPR
         8ilrpXiherwiUO0P+2QjFVlRGRKQmaY+G2KNUPT21Tatj+bKCCZimBcFqgh2o9Q1mZxE
         Msjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=srDYPq1sl5XiMrVTRNik2lXd48dAxRC5F99gwAgQsHo=;
        b=TB0XHNm7V+VhzvOlG/fITt1FhK1RhvCCGtyKNIxhL5UgfNkBMKsB2J2RgGGjtDzkFb
         ZiHpdOHs2/E3gBHl1+LVkXam9QhmOAumupPgyIOCrn9UwFFWTDkTWmmxiodt1FY7EdUL
         pR3lzKG/Y8xd/X5VRrYgXStYtPsIAnRfk00xN+o8baHCuNJNZCedb+XOlQDV1EFfAtCh
         s9/iIlwCzUnVnwwbNnXmjGwRyyye3aY6RDCXpLyJ9Tl0HY8jHph99mOgIAnEwm2VYpls
         7vsWOgroa375fNePcw08KPFnFPMSZv0HzpcDpVt/2M8fIQRW6ohUQnucrutxaBL8gkZJ
         k1nw==
X-Gm-Message-State: ANhLgQ3DJRtICY5SAZ3rdx8NYDaePXlJgWVE49lZ4E9m1Klm2MaTMRmN
        +q8UxsBVVXf6l6Y3E3QNIE8=
X-Google-Smtp-Source: ADFU+vtkHFvDdi+1CkUE0NUli2ocUDUWy1xWVqb305t7gwIeyj1OklV/SX0dh8VC03ZIo3vgyC6Oig==
X-Received: by 2002:a17:902:a407:: with SMTP id p7mr16673143plq.257.1585004963176;
        Mon, 23 Mar 2020 16:09:23 -0700 (PDT)
Received: from ?IPv6:240b:10:2720:5510:a182:288:3ffa:432a? ([240b:10:2720:5510:a182:288:3ffa:432a])
        by smtp.gmail.com with ESMTPSA id x66sm13800214pgb.9.2020.03.23.16.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 16:09:22 -0700 (PDT)
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting
 value
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20200323182324.3243-1-ikegami.t@gmail.com>
 <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Tokunori Ikegami <ikegami.t@gmail.com>
Message-ID: <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com>
Date:   Tue, 24 Mar 2020 08:09:19 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
> The change looks okay, but why do we need such a large data length ?
>
> Do you have a use-case or performance numbers ?

We use the large data length to get log page by the NVMe admin command.
In the past it was able to get with the same length but failed currently 
with it.
So it seems that depended on the kernel version as caused by the version up.
Also I have confirmed that currently failed with the length 0x10000000 
256MB.

Regards,
Ikegami

