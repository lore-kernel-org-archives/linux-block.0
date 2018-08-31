Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34530 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeHaETG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Aug 2018 00:19:06 -0400
Subject: Re: [PATCH v5 12/13] nvmet: Introduce helper functions to allocate
 and free request SGLs
To: Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-13-logang@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ebfd54ca-d3b2-249e-3927-eaa150b5a7c4@grimberg.me>
Date: Thu, 30 Aug 2018 17:14:20 -0700
MIME-Version: 1.0
In-Reply-To: <20180830185352.3369-13-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Acked-by: Sagi Grimberg <sagi@grimberg.me>
