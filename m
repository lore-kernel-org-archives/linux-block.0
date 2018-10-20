Return-Path: <valdis@vt.edu>
Sender: Valdis Kletnieks <valdis@vt.edu>
From: valdis.kletnieks@vt.edu
To: Dennis Zhou <dennis@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [BUG] ext4/block null pointer crashes in linux-next
In-Reply-To: <20181019222100.GA20900@dennisz-mbp.dhcp.thefacebook.com>
References: <13987.1539646128@turing-police.cc.vt.edu> <20181016160203.GA88193@dennisz-mbp.dhcp.thefacebook.com> <20181016182513.GA9886@dennisz-mbp.dhcp.thefacebook.com> <13448.1539791255@turing-police.cc.vt.edu> <20181017212029.GA85639@dennisz-mbp.dhcp.thefacebook.com> <14614.1539964356@turing-police.cc.vt.edu>
 <20181019222100.GA20900@dennisz-mbp.dhcp.thefacebook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1540003639_10838P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 19 Oct 2018 22:47:19 -0400
Message-ID: <19715.1540003639@turing-police.cc.vt.edu>
List-ID: <linux-block@vger.kernel.org>

--==_Exmh_1540003639_10838P
Content-Type: text/plain; charset=us-ascii

On Fri, 19 Oct 2018 18:21:00 -0400, Dennis Zhou said:

> Do you by chance run any encryption or anything on top of your hard
> drive or ssd?

ext4 on an LVM LV that's part of a PV that's inside a cryptLUKS partition on a hard drive..

So lots of nested levels there.

> I thought of another issue that may explain what's going on. It has to
> do with how a bio can go through make_request() several times. However,
> I do association on the first entry, but subsequent requests may go to
> separate queues. Therefore association and the blk_get_rl() returns the
> wrong request_list. It may be that a particular blkg doesn't have a
> fully initialized request_list.

> Thanks for being patient with me. Would you be able to try the following
> on Jens' for-4.20/block branch? His tree is available here:
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git

No problem.  I've managed to trip over issues that took a *lot* longer to resolve
(I think back around 2.5.47 or so, the PCMCIA slot in my Dell Latitude kept finding
different ways to explode the kernel for close to 8-9 months...)

I checked, and linux-next was all of 1 commit behind jens' for-4.20 tree, so
I applied it to that (I had a linux-next tree that works, but I'm a git idiot so
figuring out how to graft that tree on was going to take a while...)

Result:

Script started on 2018-10-19 22:29:32-04:00
[root@turing-police x86_64]# uname -a
Linux turing-police.cc.vt.edu 4.19.0-rc8-next-20181019-dirty #641 SMP PREEMPT Fri Oct 19 21:18:19 EDT 2018 x86_64 x86_64 x86_64 GNU/Linux
[root@turing-police x86_64]# rpm -Uvh --force dracut-049-4.git20181010.fc30.x86_64.rpm
Verifying...                          ################################# [100%]
warning: Unable to get systemd shutdown inhibition lock: Failed to connect to socket /run/dbus/system_bus_socket: No such file or directory
Preparing...                          ################################# [100%]
Updating / installing...
   1:dracut-049-4.git20181010.fc30    ################################# [100%]
[root@turing-police x86_64]# exit
exit

Script done on 2018-10-19 22:29:59-04:00

System stable, RPM works, dnf works, some good-sized compiles worked.

Looks like it's time to commit that, and add these:

Reported-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Tested-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

:)

> ---
>  block/bio.c         | 20 ++++++++++++++++++++
>  block/blk-core.c    |  1 +
>  include/linux/bio.h |  3 +++
>  3 files changed, 24 insertions(+)
>
> diff --git a/block/bio.c b/block/bio.c
> index 17a8b0aa7050..bbfeb4ee2892 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -2083,6 +2083,26 @@ int bio_associate_create_blkg(struct request_queue *q, struct bio *bio)
>  	return ret;
>  }
>
> +/**
> + * bio_reassociate_blkg - reassociate a bio with a blkg from q
> + * @q: request_queue where bio is going
> + * @bio: target bio
> + *
> + * When submitting a bio, multiple recursive calls to make_request() may occur.
> + * This causes the initial associate done in blkcg_bio_issue_check() to be
> + * incorrect and reference the prior request_queue.  This performs reassociation
> + * when this situation happens.
> + */
> +int bio_reassociate_blkg(struct request_queue *q, struct bio *bio)
> +{
> +	if (bio->bi_blkg) {
> +		blkg_put(bio->bi_blkg);
> +		bio->bi_blkg = NULL;
> +	}
> +
> +	return bio_associate_create_blkg(q, bio);
> +}
> +
>  /**
>   * bio_disassociate_task - undo bio_associate_current()
>   * @bio: target bio
> diff --git a/block/blk-core.c b/block/blk-core.c
> index cdfabc5646da..3ed60723e242 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -2433,6 +2433,7 @@ blk_qc_t generic_make_request(struct bio *bio)
>  			if (q)
>  				blk_queue_exit(q);
>  			q = bio->bi_disk->queue;
> +			bio_reassociate_blkg(q, bio);
>  			flags = 0;
>  			if (bio->bi_opf & REQ_NOWAIT)
>  				flags = BLK_MQ_REQ_NOWAIT;
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index f447b0ebb288..b47c7f716731 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -514,6 +514,7 @@ int bio_associate_blkg(struct bio *bio, struct blkcg_gq *blkg);
>  int bio_associate_blkg_from_css(struct bio *bio,
>  				struct cgroup_subsys_state *css);
>  int bio_associate_create_blkg(struct request_queue *q, struct bio *bio);
> +int bio_reassociate_blkg(struct request_queue *q, struct bio *bio);
>  void bio_disassociate_task(struct bio *bio);
>  void bio_clone_blkg_association(struct bio *dst, struct bio *src);
>  #else	/* CONFIG_BLK_CGROUP */
> @@ -522,6 +523,8 @@ static inline int bio_associate_blkg_from_css(struct bio *bio,
>  { return 0; }
>  static inline int bio_associate_create_blkg(struct request_queue *q,
>  					    struct bio *bio) { return 0; }
> +static inline int bio_reassociate_blkg(struct request_queue *q, struct bio *bio)
> +{ return 0; }
>  static inline void bio_disassociate_task(struct bio *bio) { }
>  static inline void bio_clone_blkg_association(struct bio *dst,
>  					      struct bio *src) { }
> --
> 2.17.1
>


--==_Exmh_1540003639_10838P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBW8qXN40DS38y7CIcAQJeNAf9GpcuIwKt5V1mv8fnNIyiBgwRxNcTenNP
I8fEkM7AlAK8vw3Okv4pHEofBqGVYcY3g0D6GNz4Q66M8xdbtKSxi7go8XnrOl4W
SD2lmEFlwDP0SYs8KTtOsKsnKomezLOt0IC/EZhWGUREegnKGGOKJ5/1B9X/wYR3
B27dZ57UhOOYf2Ar/LbCGk5m8GtFZoq4RZkWlSzgdE13KL6j0OUT0MgY1s90ODFD
/x/3qakHG5hlQXruQzvajrP0AvLx9qnuP1GcZsHpYK9x4fWZYlGFInvIhB2U3Yjm
yqNUsAAClzNP12LZndIOrSN3QdeuanzcaOLsOefKs/AkPlDF7kfeLg==
=L7Od
-----END PGP SIGNATURE-----

--==_Exmh_1540003639_10838P--
