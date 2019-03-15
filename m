Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3E6C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 23:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF67218AC
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 23:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfCOXHF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 19:07:05 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:39875 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfCOXHF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 19:07:05 -0400
Received: by mail-pg1-f170.google.com with SMTP id h8so7428605pgp.6;
        Fri, 15 Mar 2019 16:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VX9CP/SMsUaj5e0tQmgb14NeXAbSaVIL6H2jqL423a4=;
        b=k2ANTn7T1qY0isJGOsyxtjjpbDSGsSiR+X4Zu1/hMLEMylNKR7WDULYrds0koZCYH9
         Io0+EDw6Kl04jcMg5lqjz2iE+5WRecZo9WREYPxWLEBGYyyCB07tCyRaBC1FYJG0xk7a
         Lt/sUsKAjEcvAZrKlrp/6bLiEpb/Gi/cSRB2m9/j+/glzgd42dp60XAR4yBpKuc89l5r
         qk/Bbeyyrwl/FwiKQUZs9OnslzRJMW9xCfVHLTNbrbu0wTJq/fSAvpeH+F4/AIi6tOyl
         vc92JcmlG/x73M4uIyzscrdSM7IzUHcAjJp3pdU4LwlUgS93BPNUkTxK7VEFc8y0r8EM
         1F5Q==
X-Gm-Message-State: APjAAAUskh0ZnqGTmkH2KusA5ovW3q8ZjeXizTkmv3oU0ZCuQzuArme9
        +EGHqVjq4vKjcTLTcO60cyQ=
X-Google-Smtp-Source: APXvYqwnGd5+E0fFtHMiKzGJeicj83F9hMfCoJ/A97P+c7PI8ZihWtEQL/Xf+MTZlsTEVenArw++rQ==
X-Received: by 2002:a62:5687:: with SMTP id h7mr6553191pfj.198.1552691224744;
        Fri, 15 Mar 2019 16:07:04 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id p34sm4697606pgb.18.2019.03.15.16.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 16:07:03 -0700 (PDT)
Message-ID: <1552691222.152266.5.camel@acm.org>
Subject: Re: kernel 5.0 blk_clear_pm_only triggers a warning during resume
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 15 Mar 2019 16:07:02 -0700
In-Reply-To: <20190314101355.1df7c014@xhacker.debian>
References: <20190312132826.12c5f166@xhacker.debian>
         <1552402699.45180.106.camel@acm.org>
                <20190313101841.6d9e952b@xhacker.debian>
         <20190314101355.1df7c014@xhacker.debian>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-03-14 at 02:21 +-0000, Jisheng Zhang wrote:
+AD4 Good news. The patch fix the warning. So 
+AD4 
+AD4 Tested-by: Jisheng Zhang +ADw-Jisheng.Zhang+AEA-synaptics.com+AD4

Thank you for having tested my patch+ACE

Bart.
