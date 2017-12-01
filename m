Return-Path: <devtimhansen@gmail.com>
Return-Path: <devtimhansen@gmail.com>
Date: Fri, 1 Dec 2017 16:09:14 -0500
From: Tim Hansen <devtimhansen@gmail.com>
To: fujita.tomonori@lab.ntt.co.jp
Cc: axboe@kernel.dk, linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org, alexander.levin@one.verizon.com,
	devtimhansen@gmail.com
Subject: Re: [PATCH] bsg: update bsg_device_list to utilize static hash table
 implementation.
Message-ID: <20171201210914.nbtjus53eybi5o2n@debian>
References: <20171002161001.GA49685@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171002161001.GA49685@debian>
List-ID: <linux-block@vger.kernel.org>

This patch was submitted as an effort to standardize on Sasha's hashtable
implementation.

Just a friendly ping to get some comments on this patch, been about 2
months with no comments on it at all.  Are there any changes to be
requested or issues raised with this change?
