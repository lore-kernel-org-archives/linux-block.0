Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48039 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1757251AbcILNOQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Sep 2016 09:14:16 -0400
Subject: Re: [PATCH 5/5] nbd: add multi-connection support
To: Christoph Hellwig <hch@infradead.org>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <1473369130-22986-6-git-send-email-jbacik@fb.com>
 <20160910074340.GA24069@infradead.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <mpa@pengutronix.de>,
        <nbd-general@lists.sourceforge.net>
From: Josef Bacik <jbacik@fb.com>
Message-ID: <40321d4b-a8f6-5dfe-1aca-230b055c0f3a@fb.com>
Date: Mon, 12 Sep 2016 09:11:34 -0400
MIME-Version: 1.0
In-Reply-To: <20160910074340.GA24069@infradead.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/10/2016 03:43 AM, Christoph Hellwig wrote:
> Hi Josef,
>
> I haven't read the full path as I'm a bit in a hurry, but is there
> a good reason to not simply have a socket per-hw_ctx and store it in
> the hw_ctx private data instead of using the index in the nbd_cmd
> structure?
>

No good reason, just didn't know I could do that.  I'll fix things up to do that 
instead, thanks,

Josef
