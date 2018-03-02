Return-Path: <linus971@gmail.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CA+55aFztf2D4NwEkRxnJkD6kK62CWKxmERbALMGoMgFEGLEJZA@mail.gmail.com>
References: <20180228234006.21093-1-logang@deltatee.com> <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com> <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
 <1519936477.4592.23.camel@au1.ibm.com> <1519936815.4592.25.camel@au1.ibm.com>
 <20180301205315.GJ19007@ziepe.ca> <1519942012.4592.31.camel@au1.ibm.com>
 <CA+55aFy-oAiFJ3WDx4giR1enj65y-YJnZZhY6geFw0ygFyKXfQ@mail.gmail.com>
 <1519943658.4592.34.camel@kernel.crashing.org> <1520010446.2693.19.camel@hpe.com>
 <CA+55aFztf2D4NwEkRxnJkD6kK62CWKxmERbALMGoMgFEGLEJZA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Mar 2018 09:34:42 -0800
Message-ID: <CA+55aFzc_d3EsWZbSWDY6MKRMXEcBpYAjB2h8DxZJTuvXf1DcQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
To: "Kani, Toshi" <toshi.kani@hpe.com>
Cc: "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "hch@lst.de" <hch@lst.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
	"jglisse@redhat.com" <jglisse@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "maxg@mellanox.com" <maxg@mellanox.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "keith.busch@intel.com" <keith.busch@intel.com>,
	"oliveroh@au1.ibm.com" <oliveroh@au1.ibm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"bhelgaas@google.com" <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Mar 2, 2018 at 8:57 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Like the page table caching entries, the memory type range registers
> are really just "secondary information". They don't actually select
> between PCIe and RAM, they just affect the behavior on top of that.

Side note: historically the two may have been almost the same, since
the CPU only had one single unified bus for "memory" (whether that was
memory-mapped PCI or actual RAM). The steering was external.

But even back then you had extended bits to specify things like how
the 640k-1M region got remapped - which could depend on not just the
address, but on whether you read or wrote to it.  The "lost" 384kB of
RAM could either be remapped at a different address, or could be used
for shadowing the (slow) ROM contents, or whatever.

              Linus
