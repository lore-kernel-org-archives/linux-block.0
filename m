Return-Path: <SRS0=Ayt2=5W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4E7C2BA1B
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 18:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F782206C3
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 18:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mjOaUnzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgDFSgU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:36:20 -0400
Received: from linux.microsoft.com ([13.77.154.182]:37184 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgDFSgU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Apr 2020 14:36:20 -0400
Received: by linux.microsoft.com (Postfix, from userid 1033)
        id 51D582072933; Mon,  6 Apr 2020 11:36:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 51D582072933
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1586198179;
        bh=OEudVpLjqf3g5HvN9ndvJvlBTCIbEu5ziBVGQiVKHgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mjOaUnzZEyI7GxQRyFYX8vUHitCF4H6PoK7lk1pRlv++G6IrJNeTmOhb5EmVTDcpn
         n4FZscaj5ktDqCf4NumeUWpz8LTOqGZ+AsgyYH9Oa+oNGv29ryXsRcZJ86GfLisr1p
         aA1qDBBjfw5eGwWYF/LZ9c8SGFA/0qtV/TqlO1/U=
Date:   Mon, 6 Apr 2020 11:36:19 -0700
From:   Deven Bowers <deven.desai@linux.microsoft.com>
To:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Cc:     tyhicks@linux.microsoft.com, pasha.tatashin@soleen.com,
        sashal@kernel.org, jaskarankhurana@linux.microsoft.com,
        nramas@linux.microsoft.com, mdsakib@linux.microsoft.com
Subject: Re: [RESEND PATCH 00/11] Integrity Policy Enforcement LSM (IPE)
Message-ID: <20200406183619.GA77626@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20200406181045.1024164-1-deven.desai@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406181045.1024164-1-deven.desai@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



This was resent due to an incorrect domain for dm-devel (redhat.org vs redhat.com), and an email address
that was bouncing.

Additionally, this is an RFC, and this tag will be added in the next iteration.

- Deven
