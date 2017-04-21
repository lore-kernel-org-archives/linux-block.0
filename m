Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44294 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1038523AbdDULTX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2017 07:19:23 -0400
Subject: Re: Status of pwritev2/preadv2 in glibc?
To: Christoph Hellwig <hch@infradead.org>,
        Stephen Bates <sbates@raithlin.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        "jonathan.derrick@intel.com" <jonathan.derrick@intel.com>,
        libc-alpha@sourceware.org
References: <ECD1C373-3464-4AEF-8E73-3130C5BFAF87@raithlin.com>
 <20170421105618.GB31499@infradead.org>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <4ab1466b-5273-d3fb-8db1-3ad21578ccfc@redhat.com>
Date: Fri, 21 Apr 2017 13:19:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170421105618.GB31499@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/21/2017 12:56 PM, Christoph Hellwig wrote:
> It would probably help to add the glibc list as the glibc developers
> might know better..

So far, no one has submitted a patch.

I hope the off_t parameter is passed exactly the same way as for pwritev 
and its 64-bit variant, for all architectures.

Thanks,
Florian
