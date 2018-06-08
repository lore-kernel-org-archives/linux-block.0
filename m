Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/2] Fix bio_set copy
To: Li Wang <liwang@redhat.com>
Cc: linux-block@vger.kernel.org, snitzer@redhat.com,
 Kent Overstreet <kent.overstreet@gmail.com>, vrbagal1@linux.vnet.ibm.com,
 chuhu.ncepu@gmail.com
References: <20180607204541.13491-1-axboe@kernel.dk>
 <CAEemH2fcvMh2jS2zF0uvUuCrpL79LoBHFEQ84_bsbYkzsvMRmQ@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d4ccd010-00ab-3915-d359-322a14cdfa18@kernel.dk>
Date: Fri, 8 Jun 2018 07:13:30 -0600
MIME-Version: 1.0
In-Reply-To: <CAEemH2fcvMh2jS2zF0uvUuCrpL79LoBHFEQ84_bsbYkzsvMRmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/8/18 12:12 AM, Li Wang wrote:
> Jens Axboe <axboe@kernel.dk <mailto:axboe@kernel.dk>> wrote:
> 
>     After a recent change, dm ends up doing a straight copy of a
>     bio_set. This breaks for various items in that bio_set,
>     most notably lists. Provide a proper helper for it, and use it.
> 
> ​
> 
> I can confirm that the issue[1] was gone with this patchset applied.
> 
> 
>    Tested-by: Li Wang <liwang@redhat.com <mailto:liwang@redhat.com>>

Thanks for testing, both of you, and reporting. I'll get this pushed
upstream.

-- 
Jens Axboe
