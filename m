Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35104 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751316AbdASVc5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Jan 2017 16:32:57 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v0JLTokY030063
        for <linux-block@vger.kernel.org>; Thu, 19 Jan 2017 13:32:56 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 28354rr217-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 19 Jan 2017 13:32:56 -0800
Subject: Re: [PATCH] nbd: only set MSG_MORE when we have more to send
To: Josef Bacik <jbacik@fb.com>, <linux-block@vger.kernel.org>
References: <1484860129-14727-1-git-send-email-jbacik@fb.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <79f127ad-aadd-ed49-a60e-d7d36acfcc6d@fb.com>
Date: Thu, 19 Jan 2017 13:32:39 -0800
MIME-Version: 1.0
In-Reply-To: <1484860129-14727-1-git-send-email-jbacik@fb.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/19/2017 01:08 PM, Josef Bacik wrote:
> A user noticed that write performance was horrible over loopback and we
> traced it to an inversion of when we need to set MSG_MORE.  It should be
> set when we have more bvec's to send, not when we are on the last bvec.
> This patch made the test go from 20 iops to 78k iops.

Added for 4.10, thanks.

-- 
Jens Axboe

