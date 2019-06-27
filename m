Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3E8C48BE4
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 18:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF289205F4
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 18:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="jM9P2koo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfF0Sa6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:30:58 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:42236 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfF0Sa6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 14:30:58 -0400
Received: by mail-pf1-f170.google.com with SMTP id q10so1643480pff.9
        for <linux-block@vger.kernel.org>; Thu, 27 Jun 2019 11:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rilDmhzPi1Mu1BrfUQdjvDr8rmnfAP/fAOp8OGZaSfU=;
        b=jM9P2kooNEySABaKbrM045xmW2MFlrlNTkHbmMP8cOi4Jotx6qlPeXSt8D2RsSvwab
         xvGl321dbh7QZq5VwMgYZOf716StuPtKiJrMPGR2/UcbdCcf6vgkr2bZDdbzfG+z9vip
         wwq7IDTrgwDPrHfa6+07iGMf7+UQvxEa4QQhAAUHNXqBBbKETGma6B17l8JAB3Mrzu08
         n45ipLYEtQC2E0JFfjb8KyYDcR8sK0HeNT/BJs0j63UGUzNmLw5iZsgsZ5te3chApo81
         dV2P4yI93RQXfBCWLjCRgI3PCQohrDvamyxugQPKveVNTUElVwrRve1TmiQuMjQPtgxu
         /tuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rilDmhzPi1Mu1BrfUQdjvDr8rmnfAP/fAOp8OGZaSfU=;
        b=pPH9vW3kqbwcnAfjWrDFXUpht4QBgey8LmiF34s3pFSZ3FHFK9Uz92zq7O1ZGHaeV5
         UNGOruKRLmxzJdDlHwJLTxjMuXQ/jyL2GcKbe0qprk06R3TDM6BMfaQx0lM3NNjZEK1L
         +5BR9t/h9LknzNzhaa5FYlAeVVV5UNebwjDTEVldB41jTIHltcJbH5ofq8QC0ec7s64H
         B0trqi3jF26Vd8vUxkProO3HDa700AS/5pKvrTD2ooqAJxQs+lz8PQzY6bnVIq2VHbSB
         GezORs0DM1WHKP5mb1rNrzw6KWt8X5EOKjoslsxJqZ4ho4LBseiM46msqDfs6wq9WI9J
         lkxg==
X-Gm-Message-State: APjAAAXbopnhvEQJmJK1UFM7mowXpmjq1I5t9v3iv5PHeJk63zhj6Ie6
        Ir7HaINs17ZL8qbN0IAwFAErTw==
X-Google-Smtp-Source: APXvYqwXOIKF3FaFJ/LqhEx1aokFHpT4ZnVq4d3wAZYSBMgiVltSbR1cP0v+H/A1cMhlf+Yac3B5NA==
X-Received: by 2002:a17:90a:342c:: with SMTP id o41mr7720098pjb.1.1561660257375;
        Thu, 27 Jun 2019 11:30:57 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:5b92])
        by smtp.gmail.com with ESMTPSA id d187sm3446808pfa.38.2019.06.27.11.30.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 11:30:56 -0700 (PDT)
Date:   Thu, 27 Jun 2019 11:30:56 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Bob Liu <bob.liu@oracle.com>
Cc:     linux-block@vger.kernel.org, yi.zhang@redhat.com, osandov@fb.com
Subject: Re: [PATCH v2 blktests] block: add freeze/unfreeze sequence test
Message-ID: <20190627183056.GC31481@vader>
References: <20190610233506.23610-1-bob.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610233506.23610-1-bob.liu@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 11, 2019 at 07:35:06AM +0800, Bob Liu wrote:
> Reproduce the hang fixed by
> 7996a8b5511a ("blk-mq: fix hang caused by freeze/unfreeze sequence").

Thanks, applied.
