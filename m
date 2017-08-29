Return-Path: <guanjunxiong@huawei.com>
Subject: Re: [PATCH 07/10] nvme: track shared namespaces
To: Christoph Hellwig <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        <linux-block@vger.kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>,
        "Shenhong (C)" <shenhong09@huawei.com>,
        niuhaoxin <niuhaoxin@huawei.com>, Lilangbo <lilangbo@huawei.com>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-8-hch@lst.de>
 <ec2a91f0-5825-9cfc-50ca-afea27fd8ef3@huawei.com>
 <20170828143011.GA29260@lst.de>
From: Guan Junxiong <guanjunxiong@huawei.com>
Message-ID: <33a56620-f615-71b0-9321-bde8494132db@huawei.com>
Date: Tue, 29 Aug 2017 10:42:18 +0800
MIME-Version: 1.0
In-Reply-To: <20170828143011.GA29260@lst.de>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

Hi, Christoph

On 2017/8/28 22:30, Christoph Hellwig wrote:
> On Mon, Aug 28, 2017 at 08:41:23PM +0800, Guan Junxiong wrote:
>> If a namespace can be accessed by another subsystem,  the above line
>> will ignore such namespace.
> And that's intentional.
>

As for the __nvme_find_ns_head function, can it lookup the namespace
globally, not in the current subsytem. Take hypermetro scenario for
example, two namespaces which should be viewed as the same namespaces
from the database application but exist in two different cities respectively.
Some vendors maybe specify those two namespaces with the same UUID.

In addition, could you add a switch to turn on/off finding namespaces in
a subsystem-wide level or globally?

>> Or does the NVMe/NVMf specification constrain that any namespace
>> can only be accessed by a subsystem?
> Yes, inside the NVMe spec a Namespace is contained inside a Subsystem.
> That doesn't preclude other ways to access the LBAs, but they are outside
> the specification (e.g. also exporting them as SCSI).

Can namespace be shared between two subsystem?  If not, for hypermetro scenario,
we need keep more information of a storage array in city A synchronized with the other
in city B.
