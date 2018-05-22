Return-Path: <roman.penyaev@profitbricks.com>
MIME-Version: 1.0
In-Reply-To: <20180522131856.GK23585@mtr-leonro.mtl.com>
References: <20180518130413.16997-1-roman.penyaev@profitbricks.com>
 <20180518130413.16997-15-roman.penyaev@profitbricks.com> <20180522050513.GT7136@mtr-leonro.mtl.com>
 <CAJrWOzBLSaxdeeZTjaz2fufzYgRGJxhK38wsLQiBF5YNp+gvUw@mail.gmail.com> <20180522131856.GK23585@mtr-leonro.mtl.com>
From: Roman Penyaev <roman.penyaev@profitbricks.com>
Date: Tue, 22 May 2018 18:12:06 +0200
Message-ID: <CAJrWOzCSfpxzYFAOzaR_qzH+G3UTw+2+JaPUucbJcey4Zk=hJQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/26] ibtrs: include client and server modules into
 kernel compilation
To: Leon Romanovsky <leon@kernel.org>
Cc: linux-block <linux-block@vger.kernel.org>, linux-rdma <linux-rdma@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <bart.vanassche@sandisk.com>, Or Gerlitz <ogerlitz@mellanox.com>,
	Doug Ledford <dledford@redhat.com>, Swapnil Ingle <swapnil.ingle@profitbricks.com>,
	Danil Kipnis <danil.kipnis@profitbricks.com>, Jack Wang <jinpu.wang@profitbricks.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, May 22, 2018 at 3:18 PM, Leon Romanovsky <leon@kernel.org> wrote:
> On Tue, May 22, 2018 at 11:27:21AM +0200, Roman Penyaev wrote:
>> On Tue, May 22, 2018 at 7:05 AM, Leon Romanovsky <leon@kernel.org> wrote:
>> > On Fri, May 18, 2018 at 03:04:01PM +0200, Roman Pen wrote:
>> >> Add IBTRS Makefile, Kconfig and also corresponding lines into upper
>> >> layer infiniband/ulp files.
>> >>
>> >> Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
>> >> Signed-off-by: Danil Kipnis <danil.kipnis@profitbricks.com>
>> >> Cc: Jack Wang <jinpu.wang@profitbricks.com>
>> >> ---
>> >>  drivers/infiniband/Kconfig            |  1 +
>> >>  drivers/infiniband/ulp/Makefile       |  1 +
>> >>  drivers/infiniband/ulp/ibtrs/Kconfig  | 20 ++++++++++++++++++++
>> >>  drivers/infiniband/ulp/ibtrs/Makefile | 15 +++++++++++++++
>> >>  4 files changed, 37 insertions(+)
>> >>  create mode 100644 drivers/infiniband/ulp/ibtrs/Kconfig
>> >>  create mode 100644 drivers/infiniband/ulp/ibtrs/Makefile
>> >>
>> >> diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
>> >> index ee270e065ba9..787bd286fb08 100644
>> >> --- a/drivers/infiniband/Kconfig
>> >> +++ b/drivers/infiniband/Kconfig
>> >> @@ -94,6 +94,7 @@ source "drivers/infiniband/ulp/srpt/Kconfig"
>> >>
>> >>  source "drivers/infiniband/ulp/iser/Kconfig"
>> >>  source "drivers/infiniband/ulp/isert/Kconfig"
>> >> +source "drivers/infiniband/ulp/ibtrs/Kconfig"
>> >>
>> >>  source "drivers/infiniband/ulp/opa_vnic/Kconfig"
>> >>  source "drivers/infiniband/sw/rdmavt/Kconfig"
>> >> diff --git a/drivers/infiniband/ulp/Makefile b/drivers/infiniband/ulp/Makefile
>> >> index 437813c7b481..1c4f10dc8d49 100644
>> >> --- a/drivers/infiniband/ulp/Makefile
>> >> +++ b/drivers/infiniband/ulp/Makefile
>> >> @@ -5,3 +5,4 @@ obj-$(CONFIG_INFINIBAND_SRPT)         += srpt/
>> >>  obj-$(CONFIG_INFINIBAND_ISER)                += iser/
>> >>  obj-$(CONFIG_INFINIBAND_ISERT)               += isert/
>> >>  obj-$(CONFIG_INFINIBAND_OPA_VNIC)    += opa_vnic/
>> >> +obj-$(CONFIG_INFINIBAND_IBTRS)               += ibtrs/
>> >> diff --git a/drivers/infiniband/ulp/ibtrs/Kconfig b/drivers/infiniband/ulp/ibtrs/Kconfig
>> >> new file mode 100644
>> >> index 000000000000..eaeb8f3f6b4e
>> >> --- /dev/null
>> >> +++ b/drivers/infiniband/ulp/ibtrs/Kconfig
>> >> @@ -0,0 +1,20 @@
>> >> +config INFINIBAND_IBTRS
>> >> +     tristate
>> >> +     depends on INFINIBAND_ADDR_TRANS
>> >> +
>> >> +config INFINIBAND_IBTRS_CLIENT
>> >> +     tristate "IBTRS client module"
>> >> +     depends on INFINIBAND_ADDR_TRANS
>> >> +     select INFINIBAND_IBTRS
>> >> +     help
>> >> +       IBTRS client allows for simplified data transfer and connection
>> >> +       establishment over RDMA (InfiniBand, RoCE, iWarp). Uses BIO-like
>> >> +       READ/WRITE semantics and provides multipath capabilities.
>> >> +
>> >> +config INFINIBAND_IBTRS_SERVER
>> >> +     tristate "IBTRS server module"
>> >> +     depends on INFINIBAND_ADDR_TRANS
>> >> +     select INFINIBAND_IBTRS
>> >> +     help
>> >> +       IBTRS server module processing connection and IO requests received
>> >> +       from the IBTRS client module.
>> >> diff --git a/drivers/infiniband/ulp/ibtrs/Makefile b/drivers/infiniband/ulp/ibtrs/Makefile
>> >> new file mode 100644
>> >> index 000000000000..e6ea858745ad
>> >> --- /dev/null
>> >> +++ b/drivers/infiniband/ulp/ibtrs/Makefile
>> >> @@ -0,0 +1,15 @@
>> >> +ibtrs-client-y := ibtrs-clt.o \
>> >> +               ibtrs-clt-stats.o \
>> >> +               ibtrs-clt-sysfs.o
>> >> +
>> >> +ibtrs-server-y := ibtrs-srv.o \
>> >> +               ibtrs-srv-stats.o \
>> >> +               ibtrs-srv-sysfs.o
>> >> +
>> >> +ibtrs-core-y := ibtrs.o
>> >> +
>> >> +obj-$(CONFIG_INFINIBAND_IBTRS)        += ibtrs-core.o
>> >
>> > Will it build ibtrs-core in case both server and client are disabled in .config?
>>
>> No, CONFIG_INFINIBAND_IBTRS is selected/deselected by
>> CONFIG_INFINIBAND_IBTRS_CLIENT or CONFIG_INFINIBAND_IBTRS_SERVER,
>> when you choose them in kconfig.
>>
>
> Thanks
>
>>
>> >> +obj-$(CONFIG_INFINIBAND_IBTRS_CLIENT) += ibtrs-client.o
>> >> +obj-$(CONFIG_INFINIBAND_IBTRS_SERVER) += ibtrs-server.o
>> >> +
>> >> +-include $(src)/compat/compat.mk
>> >
>> > What is this?
>>
>> Well, in our production we use same source code and in order not to spoil
>> sources with 'ifdef' macros for different kernel versions I use compat
>> layer, which obviously will never go upstream.  This line is the only
>> clean way to keep sources always up-to-date with latest kernel and still
>> be compatible with what we have on our servers in production.
>>
>> '-' prefix at the beginning of the line tells make to ignore it if
>> file does not exist, so should not rise any error for compilation
>> against latest kernel.
>>
>> Here is an example of the compat layer for IBNBD block device:
>> https://github.com/profitbricks/ibnbd/tree/master/ibnbd/compat
>
> I see it, you will need to remove this line from the upstream kernel
> patches.

Hi Leon,

Sure.  Thanks.

--
Roman
