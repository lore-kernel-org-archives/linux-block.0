Return-Path: <jinpu.wang@profitbricks.com>
MIME-Version: 1.0
In-Reply-To: <20170324123546.GG3571@linux-x5ow.site>
References: <1490352343-20075-1-git-send-email-jinpu.wangl@profitbricks.com>
 <1490352343-20075-2-git-send-email-jinpu.wangl@profitbricks.com> <20170324123546.GG3571@linux-x5ow.site>
From: Jinpu Wang <jinpu.wang@profitbricks.com>
Date: Fri, 24 Mar 2017 13:54:04 +0100
Message-ID: <CAMGffEn7Q+Tchaj4RXV1zMk0MzHqGRv=0W5Vd1G_-GvZaG8tPA@mail.gmail.com>
Subject: Re: [PATCH 01/28] ibtrs: add header shared between ibtrs_client and ibtrs_server
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: linux-block@vger.kernel.org,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, hch <hch@lst.de>, Fabian Holler <mail@fholler.de>,
	Milind Dumbare <Milind.dumbare@gmail.com>, Michael Wang <yun.wang@profitbricks.com>,
	Kleber Souza <kleber.souza@profitbricks.com>,
	Danil Kipnis <danil.kipnis@profitbricks.com>, Roman Pen <roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

>> +
>> +#define XX(a) case (a): return #a
>
> please no macros with retun in them and XX isn't quite too descriptive as
> well.
>
> [...]
>
>> +static inline const char *ib_wc_opcode_str(enum ib_wc_opcode opcode)
>> +{
>> +     switch (opcode) {
>> +     XX(IB_WC_SEND);
>> +     XX(IB_WC_RDMA_WRITE);
>> +     XX(IB_WC_RDMA_READ);
>> +     XX(IB_WC_COMP_SWAP);
>> +     XX(IB_WC_FETCH_ADD);
>> +     /* recv-side); inbound completion */
>> +     XX(IB_WC_RECV);
>> +     XX(IB_WC_RECV_RDMA_WITH_IMM);
>> +     default: return "IB_WC_OPCODE_UNKNOWN";
>> +     }
>> +}
>
> How about:
>
> struct {
>         char *name;
>         enum ib_wc_opcode opcode;
> } ib_wc_opcode_table[] =3D {
>         { stringyfy(IB_WC_SEND), IB_WC_SEND },
>         { stringyfy(IB_WC_RDMA_WRITE), IB_WC_RDMA_WRITE },
>         { stringyfy(IB_WC_RDMA_READ ), IB_WC_RDMA_READ }
>         { stringyfy(IB_WC_COMP_SWAP), IB_WC_COMP_SWAP },
>         { stringyfy(IB_WC_FETCH_ADD), IB_WC_FETCH_ADD },
>         { stringyfy(IB_WC_RECV), IB_WC_RECV },
>         { stringyfy(IB_WC_RECV_RDMA_WITH_IMM), IB_WC_RECV_RDMA_WITH_IMM }=
,
>         { NULL, 0 },
> };
>
> static inline const char *ib_wc_opcode_str(enum ib_wc_opcode opcode)
> {
>         int i;
>
>         for (i =3D 0; i < ARRAY_SIZE(ib_wc_opcode_table); i++)
>                 if (ib_wc_opcode_table[i].opcode =3D=3D opcode)
>                         return ib_wc_opcode_table[i].name;
>
>         return "IB_WC_OPCODE_UNKNOWN";
> }
>
Looks nice, might be better to put it into ib_verbs.h?

>
> [...]
>
>> +/**
>> + * struct ibtrs_msg_hdr - Common header of all IBTRS messages
>> + * @type:    Message type, valid values see: enum ibtrs_msg_types
>> + * @tsize:   Total size of transferred data
>> + *
>> + * Don't move the first 8 padding bytes! It's a workaround for a kernel=
 bug.
>> + * See IBNBD-610 for details
>
> What about resolving the kernel bug instead of making workarounds?
I tried to send a patch upsteam, but was rejected by Sean.
http://www.spinics.net/lists/linux-rdma/msg22381.html

>
>> + *
>> + * DO NOT CHANGE!
>> + */
>> +struct ibtrs_msg_hdr {
>> +     u8                      __padding1;
>> +     u8                      type;
>> +     u16                     __padding2;
>> +     u32                     tsize;
>> +};
>
> [...]
>
> --
> Johannes Thumshirn                                          Storage
> jthumshirn@suse.de                                +49 911 74053 689
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
> GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N=C3=BCrnberg)
> Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

Thanks Johannes for review.


--=20
Jack Wang
Linux Kernel Developer

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Tel:       +49 30 577 008  042
Fax:      +49 30 577 008 299
Email:    jinpu.wang@profitbricks.com
URL:      https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Gesch=C3=A4ftsf=C3=BChrer: Achim Weiss
