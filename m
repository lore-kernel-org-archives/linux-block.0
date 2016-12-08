Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40967 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932467AbcLHW3S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 8 Dec 2016 17:29:18 -0500
Subject: Re: [PATCH] nbd: use dev_err_ratelimited in io path
To: Josef Bacik <jbacik@fb.com>, <linux-block@vger.kernel.org>,
        <kernel-team@fb.com>, <mpa@pengutronix.de>,
        <nbd-general@lists.sourceforge.net>
References: <1480972829-30845-1-git-send-email-jbacik@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <89bddfb7-72bc-2569-0e53-36acf2eff252@fb.com>
Date: Thu, 8 Dec 2016 15:28:41 -0700
MIME-Version: 1.0
In-Reply-To: <1480972829-30845-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12/05/2016 02:20 PM, Josef Bacik wrote:
> While doing stress tests we noticed that we'd get a lot of dmesg spam if
> we suddenly disconnected teh nbd device out of band.  Rate limite the
> messages in the io path in order to deal with this.

Added, with fixed up spelling.

-- 
Jens Axboe

