Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 10 May 2016 16:44:35 -0400
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
	linus.walleij@linaro.org, broonie@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH BUGFIX] block: add missing group association in
 bio-cloning functions
Message-ID: <20160510204435.GN7110@mtj.duckdns.org>
References: <x4960ul7uyw.fsf@segfault.boston.devel.redhat.com>
 <1462911821-7354-1-git-send-email-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462911821-7354-1-git-send-email-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 10, 2016 at 10:23:41PM +0200, Paolo Valente wrote:
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 6b7481f..a9ff116 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -527,11 +527,13 @@ extern unsigned int bvec_nr_vecs(unsigned short idx);
>  int bio_associate_blkcg(struct bio *bio, struct cgroup_subsys_state *blkcg_css);
>  int bio_associate_current(struct bio *bio);
>  void bio_disassociate_task(struct bio *bio);
> +void bio_clone_blkcg_association(struct bio *dst, struct bio *src);
>  #else	/* CONFIG_BLK_CGROUP */
>  static inline int bio_associate_blkcg(struct bio *bio,
>  			struct cgroup_subsys_state *blkcg_css) { return 0; }
>  static inline int bio_associate_current(struct bio *bio) { return -ENOENT; }
>  static inline void bio_disassociate_task(struct bio *bio) { }
> +void bio_clone_blkcg_association(struct bio *dst, struct bio *src) { return 0; }
   ^
   static inline

-- 
tejun
