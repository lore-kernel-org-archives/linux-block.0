Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED70C433DF
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 23:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB79207C4
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 23:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PkphyJ7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgESXeZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 19:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgESXeY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 19:34:24 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506D6C061A0E
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 16:34:24 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id l1so1166635qtp.6
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 16:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=83We/Mr70MD4EiPjp3ORsT3cMcT/fqJs14tN4jNeALQ=;
        b=PkphyJ7hrxzRIXZc1vTx3ePPg+qMN0P9FJW23j3vkeG6cR/IEDJ/PwVVPr6rCKgWR0
         uxvwEXp4zKZdEVYxUY69qlwGe5ZyVTaJGaaT1bzFTVKt1vgr7pxDlsnYxf8Y0d1Ovgwn
         OzKAq6f/cur7NV34ENpzm4F/vlOOfNELAQKKSPDLo9i97t3S/vYUWxDYZL3Q2xnNSNfd
         MqzNBNj2mMHsZWOpwpsmZ2GcyYXih8I1LBb+TP9g4008Yky3ReTsA98JRP0oJX+Bop8+
         5cIa+4xSluFY0CXJ/PN+E3BAs/d+atY3iqCAmZ4R+Fg60LjUmaWFJsv2N3+6RZCpwYRa
         FPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=83We/Mr70MD4EiPjp3ORsT3cMcT/fqJs14tN4jNeALQ=;
        b=siIUKKyyuzP9wUvhsXqW8SykETHueJMLEuD2UQT/A2yYb9nK4sTUoqI7puFXV5e8JU
         eToxLP4y0N4VCAy/eAZFP+nxyQPaT2HIdP3pUNq02y5jhY54rGWb7UbZVnFWKJappl0h
         Rd4AjfVbLCBu96b+mjiMlYWMFstZwqe1Xve9omRUj2LJxcm3ZypqsipT4zmb3UbTKqBt
         ge7CeOca6HpiqdYy8DcvJFz0M7/VI0m7Jw1HuIVQq5r+RO8ZxGpfpPdD9ITgffOHG6ly
         b4eln2JLUOzDadukvZqiPqQ45eKj40o1h9NZt31wPoRSfwEdSj2kIIqA4eTi9RZvae1x
         zyOw==
X-Gm-Message-State: AOAM5337vtwf3Jp+4VXRn7KJ4LfhwQ1IVhHfHthIvZSd+vnodU7JZ1gF
        QeP5/f2q6rHbQ3bjWV5R7LiQwQ==
X-Google-Smtp-Source: ABdhPJygMA9fyOWgOnUo1Gb9cez3ltp5DMCbIVcY0rTqNsUnj53c07XtG+LOljH5lXbHjeZzzd6pXA==
X-Received: by 2002:aed:2b67:: with SMTP id p94mr2555408qtd.255.1589931263151;
        Tue, 19 May 2020 16:34:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id z25sm1069973qtj.75.2020.05.19.16.34.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 16:34:22 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbBkc-0003Tj-1A; Tue, 19 May 2020 20:34:22 -0300
Date:   Tue, 19 May 2020 20:34:22 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     linux-rdma@vger.kernel.org, linux-next@vger.kernel.org,
        jinpu.wang@cloud.ionos.com, dledford@redhat.com, axboe@kernel.dk,
        linux-block@vger.kernel.org, bvanassche@acm.org,
        rdunlap@infradead.org, leon@kernel.org
Subject: Re: [PATCH 0/1] Fix RTRS compilation with block layer disabled
Message-ID: <20200519233422.GB12656@ziepe.ca>
References: <e132ee19-ff55-c017-732c-284a3b20daf7@infradead.org>
 <20200519080136.885628-1-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519080136.885628-1-danil.kipnis@cloud.ionos.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 19, 2020 at 10:01:35AM +0200, Danil Kipnis wrote:
> Hi Jason, Hi All,
> 
> this fixes the compilation problem reported by Randy Dunlap for RTRS on
> rdma for-next.
> 
> Jason, am I even doing the right thing sending the fixes for the issues
> reported for the for-next for RTRS/RNBD to here?

Yes, I will take them.

Do not send cover letters for single patches please

Jason
