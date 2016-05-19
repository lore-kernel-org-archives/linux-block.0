Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Subject: Re: [PATCH v4 0/6] Add alignment check for DAX mount
To: Toshi Kani <toshi.kani@hpe.com>, dan.j.williams@intel.com,
	jack@suse.cz, david@fromorbit.com, viro@zeniv.linux.org.uk
References: <1462897437-16626-1-git-send-email-toshi.kani@hpe.com>
Cc: axboe@fb.com, hch@infradead.org, boaz@plexistor.com, tytso@mit.edu,
	adilger.kernel@dilger.ca, ross.zwisler@linux.intel.com,
	micah.parrish@hpe.com, linux-nvdimm@lists.01.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <f265e4ce-9271-1d83-35bc-794f2e2129df@sandeen.net>
Date: Thu, 19 May 2016 18:37:12 -0500
MIME-Version: 1.0
In-Reply-To: <1462897437-16626-1-git-send-email-toshi.kani@hpe.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On 5/10/16 11:23 AM, Toshi Kani wrote:
> When a partition is not aligned by 4KB, mount -o dax succeeds,

Sorry for being late, but -

Shouldn't this and all subsequent patch commits refer to
PAGE_SIZE, rather than "4kB?"

-Eric

