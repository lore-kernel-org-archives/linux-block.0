Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54865 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751389AbdAMXM6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2017 18:12:58 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.17/8.16.0.17) with SMTP id v0DMMDeN016176
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2017 14:30:16 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 27xjfxtsp3-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2017 14:30:16 -0800
Subject: Re: [PATCH] nbd: use an idr to keep track of nbd devices
To: Josef Bacik <jbacik@fb.com>, <linux-block@vger.kernel.org>,
        <kernel-team@fb.com>
References: <1484334292-29933-1-git-send-email-jbacik@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <b1f8f887-72e2-fda6-b9b1-0a0f87d604b1@fb.com>
Date: Fri, 13 Jan 2017 15:30:07 -0700
MIME-Version: 1.0
In-Reply-To: <1484334292-29933-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/13/2017 12:04 PM, Josef Bacik wrote:
> To prepare for dynamically adding new nbd devices to the system switch
> from using an array for the nbd devices and instead use an idr.  This
> copies what loop does for keeping track of its devices.

What's this against? Doesn't apply to the 4.11 branch, nor the for-linus
branch.

-- 
Jens Axboe

