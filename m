Return-Path: <SRS0=Tgdl=NX=linuxfoundation.org=gregkh@kernel.org>
Date: Mon, 12 Nov 2018 04:28:40 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Li Zefan <lizefan@huawei.com>,
	Angelo Ruocco <angeloruocco90@gmail.com>,
	Dennis Zhou <dennis@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Liu Bo <bo.liu@linux.alibaba.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Johannes Weiner <hannes@cmpxchg.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
	linus.walleij@linaro.org, broonie@kernel.org,
	bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 01/12] kernfs: add function to find kernfs_node without
 increasing ref counter
Message-ID: <20181112122840.GA1429@kroah.com>
References: <20181112095632.69114-1-paolo.valente@linaro.org>
 <20181112095632.69114-2-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181112095632.69114-2-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

On Mon, Nov 12, 2018 at 10:56:21AM +0100, Paolo Valente wrote:
> From: Angelo Ruocco <angeloruocco90@gmail.com>
> 
> The kernfs pseudo file system doesn't export any function to only find
> a node by name, without also getting a reference on it.
> But in some cases it is useful to just locate a kernfs node, while
> using it or not depends on some other condition.
> 
> This commit adds a function to just look for a node, without getting
> a reference on it.

Eeek, that sounds really bad.  So you save off a pointer to something,
and have no idea if that pointer now really is valid or not?  It can
instantly disappear right afterwards.

This feels wrong, what is the problem of having a properly reference
counted object passed back to you that you have to create a dangerous
function like this?

greg k-h
