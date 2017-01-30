Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:49237 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752867AbdA3M3D (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2017 07:29:03 -0500
Date: Mon, 30 Jan 2017 13:28:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, snitzer@redhat.com, toshi.kani@hpe.com,
        mawilcox@microsoft.com, linux-block@vger.kernel.org,
        jmoyer@redhat.com, linux-fsdevel@vger.kernel.org,
        ross.zwisler@linux.intel.com, hch@lst.de
Subject: Re: [RFC PATCH 01/17] dax: refactor dax-fs into a generic provider
        of dax inodes
Message-ID: <20170130122817.GC9043@lst.de>
References: <148559256378.11180.8957776806175202312.stgit@dwillia2-desk3.amr.corp.intel.com> <148559256970.11180.2541041546993320141.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <148559256970.11180.2541041546993320141.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I really don't like the dax_inode name.  Why not something like
dax_device or dax_region?
