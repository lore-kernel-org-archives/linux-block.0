Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33993 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751571AbdBXXB5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Feb 2017 18:01:57 -0500
Subject: Re: [PATCH V2 2/3] PCI: add an API to get node from vector
To: Bjorn Helgaas <helgaas@kernel.org>, Shaohua Li <shli@fb.com>
References: <a52afb3e09691267f2240331ef0b9962f793703d.1485971427.git.shli@fb.com>
 <d0f9b1bda8c27f058c95f88015e013b9d8131dc0.1485971427.git.shli@fb.com>
 <20170224222943.GB26430@bhelgaas-glaptop.roam.corp.google.com>
CC: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <bhelgaas@google.com>, <hch@lst.de>
From: Jens Axboe <axboe@fb.com>
Message-ID: <0d5a492c-33b2-27b4-38f6-3087616a8cb5@fb.com>
Date: Fri, 24 Feb 2017 15:34:44 -0700
MIME-Version: 1.0
In-Reply-To: <20170224222943.GB26430@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/24/2017 03:29 PM, Bjorn Helgaas wrote:
> On Wed, Feb 01, 2017 at 09:53:15AM -0800, Shaohua Li wrote:
>> Next patch will use the API to get the node from vector for nvme device
>>
>> Signed-off-by: Shaohua Li <shli@fb.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Sorry I missed this; I normally work from the linux-pci patchwork, and
> this didn't show up there because it wasn't cc'd to linux-pci.  But I
> should have noticed anyway.

Thanks Bjorn!

-- 
Jens Axboe
