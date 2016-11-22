Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57007 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755655AbcKVTSW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Nov 2016 14:18:22 -0500
Subject: Re: [PATCH][V5] nbd: add multi-connection support
To: Josef Bacik <jbacik@fb.com>, <linux-block@vger.kernel.org>,
        <kernel-team@fb.com>, <w@uter.be>, <alex@alex.org.uk>,
        <nbd-general@lists.sourceforge.net>, <mpa@pengutronix.de>
References: <1479841480-18094-1-git-send-email-jbacik@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <29bd552f-e33b-782f-f22e-2a3464870cd8@fb.com>
Date: Tue, 22 Nov 2016 12:18:00 -0700
MIME-Version: 1.0
In-Reply-To: <1479841480-18094-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 11/22/2016 12:04 PM, Josef Bacik wrote:
> NBD can become contended on its single connection.  We have to serialize all
> writes and we can only process one read response at a time.  Fix this by
> allowing userspace to provide multiple connections to a single nbd device.  This
> coupled with block-mq drastically increases performance in multi-process cases.
> Thanks,

Added for 4.10, thanks Josef.

-- 
Jens Axboe

