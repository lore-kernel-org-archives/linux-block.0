Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A475C4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 16:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C54B20645
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 16:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfF1QUF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:20:05 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:36965 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfF1QUF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 12:20:05 -0400
Received: by mail-pf1-f178.google.com with SMTP id 19so3234508pfa.4
        for <linux-block@vger.kernel.org>; Fri, 28 Jun 2019 09:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/ETHKHLKJuNOo4+w43DRw8i/76pXdOoH92C7kXzYDWU=;
        b=ibWsT8Du6shy0/08eZRSCUud+pCIBlbKYb3Wd4JtiZ0vR1Unpco/dccx9FEpA5wZQu
         /zH1AGWYU+I45aJBd5cuCIl33rbsXl1btQ51fbGj2bElANaSvRVG9/F8A/IITm9QXDq8
         5du4zioN11elU0zrxQeiSlMyK30BnvVZus9pvSmuDIRL433wNbCPN9I9HXnIoDLxs4J4
         +lJgCLV3569iKTnywo8UeaxNNjRmetRwZfq5MM94r9frzqKiDUJLABfBMylWdUguECWb
         kmONDfzPTi76UzgxJI846xr56aJEyohRYku1XzIaxPZzKI/D0bUafXNt6OPnHRPQdbl2
         El0g==
X-Gm-Message-State: APjAAAXRFUFVifn2riJw1KxxMZQOo4Calnbv92nPMCysjecGUVlj0QOK
        lnqgP3dBtghSobYSrkJgTYmFPHdrez0=
X-Google-Smtp-Source: APXvYqxUJ+JNNNCZ06S3hLaPJXWtffZ5RwMPDDaUmcNUjyLeQmPDkljXLxLQ0RNH4P1DO42qlcv9Bg==
X-Received: by 2002:a63:2c43:: with SMTP id s64mr10011954pgs.50.1561738803991;
        Fri, 28 Jun 2019 09:20:03 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id g6sm2098683pgh.64.2019.06.28.09.20.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 09:20:02 -0700 (PDT)
Subject: Re: [REGRESSION] commit c2b3c170db610 causes blktests block/002
 failure
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Omar Sandoval <osandov@fb.com>,
        Andi Kleen <ak@linux.intel.com>, linux-block@vger.kernel.org
References: <20190609181423.GA24173@mit.edu>
 <e84b29e1-209e-d598-0828-bed5e3b98093@acm.org> <20190627171438.GA31481@vader>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <448fea62-23b9-3df3-4ec0-cc994abaff28@acm.org>
Date:   Fri, 28 Jun 2019 09:20:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190627171438.GA31481@vader>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/27/19 10:14 AM, Omar Sandoval wrote:
> I can reproduce the failure. I'll try to find a reliable way to wait,
> otherwise I'll probably just toss a sleep in here.

Thanks!

Bart.


