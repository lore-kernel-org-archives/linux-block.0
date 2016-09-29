Return-Path: <linux-scsi-owner@vger.kernel.org>
From: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: hans.verkuil@cisco.com, brking@us.ibm.com,
        haver@linux.vnet.ibm.com, ching2048@areca.com.tw, axboe@fb.com,
        alex.williamson@redhat.com, kvm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] genwqe: use pci_irq_allocate_vectors
References: <1473600688-24043-1-git-send-email-hch@lst.de>
        <1473600688-24043-6-git-send-email-hch@lst.de>
        <87twcyk1cd.fsf@linux.vnet.ibm.com> <20160929183757.GA4106@lst.de>
Date: Thu, 29 Sep 2016 15:45:29 -0300
In-Reply-To: <20160929183757.GA4106@lst.de> (Christoph Hellwig's message of
        "Thu, 29 Sep 2016 20:37:57 +0200")
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87lgyak0ja.fsf@linux.vnet.ibm.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> On Thu, Sep 29, 2016 at 03:28:02PM -0300, Gabriel Krisman Bertazi wrote:
>> Christoph Hellwig <hch@lst.de> writes:
>> 
>> > Simply the interrupt setup by using the new PCI layer helpers.
>> 
>> Good clean up.  Tested and:
>> 
>> Acked-by: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
>
> Which tree should this go in through?

I'd say Greg's char-misc tree.

I'm stepping up to assist with the genwqe_card driver just now, since we
(ibm) missed some of the last patches that went in.  I'll add myself to
maintainers file.


-- 
Gabriel Krisman Bertazi

