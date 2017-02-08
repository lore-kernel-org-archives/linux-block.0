Return-Path: <dan.j.williams@intel.com>
MIME-Version: 1.0
In-Reply-To: <20170208102349.GA27541@quack2.suse.cz>
References: <20170131125429.14303-1-jack@suse.cz> <2851869.q2N89k4IqL@morokweng>
 <1790906.I1Z25HtRf4@morokweng> <20170207123331.GD13524@quack2.suse.cz>
 <20170207172101.GC6164@htj.duckdns.org> <20170208075142.GA26317@quack2.suse.cz>
 <20170208102349.GA27541@quack2.suse.cz>
From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 8 Feb 2017 08:00:26 -0800
Message-ID: <CAPcyv4gk3HMFcxb3WTp-e+XkANH-KLofnaA2oKU7FpTOLs3T+g@mail.gmail.com>
Subject: Re: [PATCH 0/4 v2] BDI lifetime fix
To: Jan Kara <jack@suse.cz>
Cc: Tejun Heo <tj@kernel.org>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>, Laurent Dufour <ldufour@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 8, 2017 at 2:23 AM, Jan Kara <jack@suse.cz> wrote:
> On Wed 08-02-17 08:51:42, Jan Kara wrote:
[..]
> <DETOUR BEGIN>
> This ordering seems to be the real culprit of the bdi name reuse problems
> Omar has reported? Same as described in commit 6cd18e711dd8 for MD BTW and
> Dan's patch could be IMHO replaced by a move of bdi_unregister() from
> blk_cleanup_queue() to del_gendisk() where it logically belongs as a
> counterpart of device_add_disk(). I'll test that.
> <DETOUR END>

I'd support that change. This is is why I called my fix "brute-force",
it just accommodated the existing problematic ordering.
