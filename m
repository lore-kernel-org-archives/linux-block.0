Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61906C43219
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 20:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CED2077C
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 20:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jxj3YC46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfDYUDi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 16:03:38 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:38910 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729270AbfDYUDi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 16:03:38 -0400
Received: by mail-pf1-f175.google.com with SMTP id 10so452654pfo.5
        for <linux-block@vger.kernel.org>; Thu, 25 Apr 2019 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9yZuN8hvykudgvqjrkfkc1ddrIcEZdCLKTPcwNCLMaA=;
        b=jxj3YC4680nC3zgF6cxPeQHLgK/iGzN8Tlj+mFFLrNeeHkYLFqrD5kBQK+MA+ABrpD
         3HdZY+SI810355Q34UQn5l2YkoF2qygTmnfaRRT418kKcjgGRNkalZyvVZnghNKrKk+5
         8YiEcFjel1sFB9TrDXKMonDt4VsQx4nJTS14VV/caPIvx5YvPh6m5JaQKjHXFUtfflKZ
         CkZroAWM8JAi/N5Kg1k21//RnYVPH4vypnIv/cJq/2vVcN7eCsKyB76PjqpVQfzy1Lbr
         VuXMCaokC5PBgIf40n6iBXQjGCWpJwTK3hJ7gl3UmaV4LvMrrEmI6P3aoDHIlBvc7pQs
         rdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9yZuN8hvykudgvqjrkfkc1ddrIcEZdCLKTPcwNCLMaA=;
        b=ZF/4VA5WneFARimxwlwz1sG2QsV/CAb2uvCCzGQt4a7JO9/8J1H148Tbe1NL52NUd5
         sc40pVaVaoVMeAF3TdQRoztEP7xqF063dyVnKHs35Bif3l8HRKUhO+DV0kPfxgk17376
         DFLKqWlMPI9w1rEdKkVGWLUDs/NogZJ1v5bzzEHAgmzxH1bDUNuJpVrmCjHdf3CCysTO
         OxPl+9c1vT781KFGy9Ei1ypZc3BBfci+AsueHEgzY3/la/imVLLUKZ7yCVY8UsjqJx9h
         FrCh681PWCEOHuQ9vVgUX9YGvVCVevT1yC2QSDgKqdKSnADR7b2uCD0idyF7ANZ9DsXT
         M7HA==
X-Gm-Message-State: APjAAAWrqI9ATAs7gB/qq9BrCJ1jFRm3Nsoh/hF4klJoumuSPgoWPGLy
        H6pWUFKgYWIRXaNQqJ7mOBYyWA==
X-Google-Smtp-Source: APXvYqzinmBulxOLUVkKOmvGyBuy+TAx1zleDgIu4dJ1S/hJNTGiV/7BAXP7lqbewJBtfWlGuzpvDg==
X-Received: by 2002:a65:5286:: with SMTP id y6mr38424683pgp.79.1556222616888;
        Thu, 25 Apr 2019 13:03:36 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id b1sm26204135pgq.15.2019.04.25.13.03.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 13:03:35 -0700 (PDT)
Subject: Re: [LSF/MM] Preliminary agenda ? Anyone ... anyone ? Bueller ?
To:     Jerome Glisse <jglisse@redhat.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190425200012.GA6391@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <83fda245-849a-70cc-dde0-5c451938ee97@kernel.dk>
Date:   Thu, 25 Apr 2019 14:03:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425200012.GA6391@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/25/19 2:00 PM, Jerome Glisse wrote:
> Did i miss preliminary agenda somewhere ? In previous year i think
> there use to be one by now :)

You should have received an email from LF this morning with a subject
of:

LSFMM 2019: 8 Things to Know Before You Arrive!

which also includes a link to the schedule. Here it is:

https://docs.google.com/spreadsheets/d/1Z1pDL-XeUT1ZwMWrBL8T8q3vtSqZpLPgF3Bzu_jejfk

-- 
Jens Axboe

