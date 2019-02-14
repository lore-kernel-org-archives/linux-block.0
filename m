Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637E2C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 23:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3676C21B1C
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 23:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfBNX00 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:26:26 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34194 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfBNX00 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 18:26:26 -0500
Received: by mail-pf1-f195.google.com with SMTP id j18so3890270pfe.1;
        Thu, 14 Feb 2019 15:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UQzltzTNR2DFIy/YMXkmVDwXTcBYlDtpfvpNhKXU5N8=;
        b=O57WsCnGSaoAw+gjmu3TroC0e6Mzcm0riNR58ef6hJzLAKhEfdoHb9054ZZkLlx0NT
         Kz1p5cKarf2v0ey8mkZ1gJl7KPf3pehm3l/6uqTQ8FSYKVXPsHmNfp2iU5PmHOwXmt1V
         cKvGOBsgUaC1tx5QAvfNQqwQEh5dR5fTa6Xhv5h8RfyZyybxEJuVL96+WlOAuke/nZDu
         pdpzvdxUCu5fxMBFbdv+D9y1xEyuTpG2UVEa6bOM5LTq6UW+IIpvfSxdtVfV0kGMwQSZ
         Qu+35Pha/4tlFZAF/9OCF8mHj2jpzIihT6CQmEJMqHE+hnWGGSkzxrK96LF8UKp1IXnI
         8qYQ==
X-Gm-Message-State: AHQUAuYsyGIp0z56/tv06EuaTpdTfVfDi8cmAyOwXtESRn69oQu/e1SW
        BDnLliNtpzLAQz8SDsUUfhQ=
X-Google-Smtp-Source: AHgI3Ia0J61KHs7D6lZX5W1eoY68fqQOuZ9h8kGrbV/LNOC52yk8ergt0E8k6mtJN3j2m16hVe5BRg==
X-Received: by 2002:aa7:8249:: with SMTP id e9mr6691427pfn.93.1550186785107;
        Thu, 14 Feb 2019 15:26:25 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id s1sm4496036pfe.163.2019.02.14.15.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 15:26:24 -0800 (PST)
Message-ID: <1550186783.31902.81.camel@acm.org>
Subject: Re: [LSF/MM TOPIC] improving storage testing
From:   Bart Van Assche <bvanassche@acm.org>
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Thu, 14 Feb 2019 15:26:23 -0800
In-Reply-To: <20190214105507.GA9739@linux-x5ow.site>
References: <20190213180754.GX23000@mit.edu>
         <20190214105507.GA9739@linux-x5ow.site>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-02-14 at 11:55 +-0100, Johannes Thumshirn wrote:
+AD4 On Wed, Feb 13, 2019 at 01:07:54PM -0500, Theodore Y. Ts'o wrote:
+AD4 +AD4 Also, there are expectations about minimum versions of bash that can
+AD4 +AD4 be supported+ADs but there aren't necessarily for other components such
+AD4 +AD4 as nvme-cli, and I suspect that it is due to the use of a overly new
+AD4 +AD4 version of nvme-cli from its git tree.  Is that supposed to work, or
+AD4 +AD4 should I constrain myself to whatever version is being shipped in
+AD4 +AD4 Fedora or some other reference distribution?  More generally, what is
+AD4 +AD4 the overall expectations that should be expected?  xfstests has some
+AD4 +AD4 extremely expansive set of sed scripts to normalize shell script
+AD4 +AD4 output to make xfstests extremely portable+ADs will patches along similar
+AD4 +AD4 lines something that we should be doing for blktests?
+AD4 
+AD4 I think this is the root cause of the problems you've sent out mails for this
+AD4 week. A lot of blktests test need filtering. See +AFs-1+AF0 as an example.
+AD4 
+AD4 +AFs-1+AF0 https://github.com/osandov/blktests/pull/34

Hi Johannes,

Output of tools like nvme-cli is not an ABI although an ABI is what is
required to make blktests work reliably. One possible approach is to modify
nvme-cli such that it has two output formats: one output format that is
intended for humans and another that is easy to parse by software. I think
we should consider that approach and compare it to using sed scripts.

Bart.
