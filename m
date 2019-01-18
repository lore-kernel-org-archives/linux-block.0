Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF33FC43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 02:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FB052087E
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 02:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfARCxe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 21:53:34 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:36484 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfARCxe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 21:53:34 -0500
Received: by mail-pf1-f172.google.com with SMTP id b85so5821645pfc.3;
        Thu, 17 Jan 2019 18:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M7BzZURXlPsa4cII/baSEe4psByFQkYhr7b0zz2Rrn4=;
        b=eH2tLRTHs5qSn0AbC1/DCz+terPSN6p7YpjWK5haQ0dCRk9SZx0Ua7/cdnLWlgRznq
         Ii2ap3hBX5sJvw1swNaCaW0aXtaiWlg3K3YhqZUZFDpwrkFQOl4WFTQFGDFm318QKw3A
         Y89+hvCFfQvCVLbGFxcUBybIzJZ6Hh/M8D6HIcMPpmSOOtEoWHgxTv3lEJG/BFe4lrFK
         eNprLpiwdeM630i+QU/GDAHBahXVaIIMbXcd0Xe9El6rVeaUsyMQ5sDAl/VTJ8mQvyM7
         my5PjRzCywLbLt4gE/UWb0Xl4cqOS72Y/8ofyeLzJ5xt24gywXJ43Kh0pAQwpZ4AK1OZ
         S8tA==
X-Gm-Message-State: AJcUukdnaYSMG+dn8w4eMdTpPLXlYvhOre04H3oacvOnoLCmVSJd71Ep
        j5mM1e142AoGQ3WwmqQNOPILXFF3
X-Google-Smtp-Source: ALg8bN4+/XAs+h5ttFCqLMfIpliflqrFKJSSUrtM+SashTHW6l3bkcf86j+C/XCgkMx4Ii7ipzUZmw==
X-Received: by 2002:a63:441e:: with SMTP id r30mr16133677pga.128.1547780012822;
        Thu, 17 Jan 2019 18:53:32 -0800 (PST)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id o1sm4467386pgn.63.2019.01.17.18.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 18:53:31 -0800 (PST)
Subject: Re: [patch 1/9] block: Cleanup license notice
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
References: <20190117231416.111952141@linutronix.de>
 <20190117231500.874215239@linutronix.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <1ee7cf07-5077-a331-3aab-ae107df02ef2@acm.org>
Date:   Thu, 17 Jan 2019 18:53:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190117231500.874215239@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/19 3:14 PM, Thomas Gleixner wrote:
> Remove the imprecise and sloppy:
> 
>    "This files is licensed under the GPL."
> 
> license notice in the top level comment.
> 
> 1) The file already contains a SPDX license identifier which clearly
>     states that the license of the file is GPL V2 only
> 
> 2) The notice resolves to GPL v1 or later for scanners which is just
>     contrary to the intent of SPDX identifiers to provide clear and non
>     ambiguous license information. Aside of that the value add of this
>     notice is below zero,

My intent was to release this under GPL v2, hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
