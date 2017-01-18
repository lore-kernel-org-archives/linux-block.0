Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33547 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751805AbdARGBo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Jan 2017 01:01:44 -0500
Received: by mail-oi0-f53.google.com with SMTP id w204so1826768oiw.0
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2017 22:01:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170118052533.GA18349@bombadil.infradead.org>
References: <20170114002008.GA25379@linux.intel.com> <20170118052533.GA18349@bombadil.infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 17 Jan 2017 22:01:30 -0800
Message-ID: <CAPcyv4jNz=1QdPPtM2A=3avGtVvZG=2d9JC-JD_F6u+-CYQN4g@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] Future direction of DAX
To: willy@bombadil.infradead.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        linux-block@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jan 17, 2017 at 9:25 PM,  <willy@bombadil.infradead.org> wrote:
> On Fri, Jan 13, 2017 at 05:20:08PM -0700, Ross Zwisler wrote:
>> We still have a lot of work to do, though, and I'd like to propose a discussion
>> around what features people would like to see enabled in the coming year as
>> well as what what use cases their customers have that we might not be aware of.
>
> +1 to the discussion
>
>> - Jan suggested [2] that we could use the radix tree as a cache to service DAX
>>   faults without needing to call into the filesystem.  Are there any issues
>>   with this approach, and should we move forward with it as an optimization?
>
> Ahem.  I believe I proposed this at last year's LSFMM.  And I sent
> patches to start that work.  And Dan blocked it.  So I'm not terribly
> amused to see somebody else given credit for the idea.
>

I "blocked" moving the phys to virt translation out of the driver
since that mapping lifetime is device specific.

However, I think caching the file offset to physical sector/address
result is a great idea.
