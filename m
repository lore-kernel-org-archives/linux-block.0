Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751106AbdFUNTh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jun 2017 09:19:37 -0400
From: Florian Weimer <fweimer@redhat.com>
Subject: Re: pwritev2 regression test for invalid flags
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Cc: GNU C Library <libc-alpha@sourceware.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
References: <A4491A52-483F-47CD-8248-04C519C126C2@raithlin.com>
 <febd41fd-af60-040d-e16e-a7566b57583b@redhat.com>
 <cd8eafd8-76c7-5215-1aea-457e259f85af@linaro.org>
 <791e2720-aad6-2084-4d47-eb4d6b9acfe2@redhat.com>
 <a85b46a7-152b-6601-ace2-53acd645119e@linaro.org>
Message-ID: <5a060977-73b9-9eff-b99e-6019e1333268@redhat.com>
Date: Wed, 21 Jun 2017 15:19:32 +0200
MIME-Version: 1.0
In-Reply-To: <a85b46a7-152b-6601-ace2-53acd645119e@linaro.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/21/2017 03:11 PM, Adhemerval Zanella wrote:

> Yes, we will need to update the testcase in case of newer flags additions. 
> But since the flags are currently defined within GLIBC not pulling from 
> kernel header I think we will have more control over it.

But that doesn't really matter because we need something to trigger
EINVAL from the running kernel.  -1 should be safe for now, though.

Florian
