Return-Path: <gerlitz.or@gmail.com>
MIME-Version: 1.0
In-Reply-To: <08889344-db9d-cf46-6cfb-56764042f578@grimberg.me>
References: <20180205220316.30236-1-sagi@grimberg.me> <CAJ3xEMgPfchks6wFUL8S1OJwv9JCcTtCmXz5ZdtR2HvKYQAFUg@mail.gmail.com>
 <08889344-db9d-cf46-6cfb-56764042f578@grimberg.me>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Tue, 6 Feb 2018 13:34:21 +0200
Message-ID: <CAJ3xEMi0FfPgiZkpVJNdcuykK5v6cUzR5uj6nAHUK6evTUXqbA@mail.gmail.com>
Subject: Re: [PATCH rfc 0/5] generic adaptive IRQ moderation library for I/O devices
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	RDMA mailing list <linux-rdma@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Idan Burstein <idanb@mellanox.com>,
	Bart Van Assche <bart.vanassche@wdc.com>, Tal Gilboa <talgi@mellanox.com>,
	Andy Gospodarek <gospo@broadcom.com>, Saeed Mahameed <saeedm@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 6, 2018 at 11:25 AM, Sagi Grimberg <sagi@grimberg.me> wrote:
> Hey Or,
>
>> not any more, Andy and Tal made the mlx5 AM code a kernel library
>> which is called DIM
>>
>> f4e5f0e MAINTAINERS: add entry for Dynamic Interrupt Moderation
>> 6a8788f bnxt_en: add support for software dynamic interrupt moderation
>> 8115b75 net/dim: use struct net_dim_sample as arg to net_dim
>> 4c4dbb4 net/mlx5e: Move dynamic interrupt coalescing code to include/linux
>> 9a31742 net/mlx5e: Change Mellanox references in DIM code
>> b9c872f net/mlx5e: Move generic functions to new file
>> f5e7f67 net/mlx5e: Move AM logic enums
>> 138968e net/mlx5e: Remove rq references in mlx5e_rx_am
>> f58ee09 net/mlx5e: Move interrupt moderation forward declarations
>> 98dd1ed net/mlx5e: Move interrupt moderation structs to new file
>>
>> can you make use of that? cc-ing them in case you have questions/comments
>
>
> Thanks a lot for the pointer, I'm not following net-next regularly.
> This seems to be a copy of the mlx5 code.

Just to make it clear, the code was moved to a library and not copied... so
there's single instance of the code upstream and lets try to find a way for
your use case to take advantage of it possibly under some modifications.
