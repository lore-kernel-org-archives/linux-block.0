Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ot0-f178.google.com ([74.125.82.178]:34144 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbdA3RMP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Jan 2017 12:12:15 -0500
Received: by mail-ot0-f178.google.com with SMTP id f9so247000839otd.1
        for <linux-block@vger.kernel.org>; Mon, 30 Jan 2017 09:12:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170130122817.GC9043@lst.de>
References: <148559256378.11180.8957776806175202312.stgit@dwillia2-desk3.amr.corp.intel.com>
 <148559256970.11180.2541041546993320141.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20170130122817.GC9043@lst.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 30 Jan 2017 09:12:14 -0800
Message-ID: <CAPcyv4jx433Y1As=GjpjYcLVLBHyJvXtTdrs-kmo_K4pkKfzGQ@mail.gmail.com>
Subject: Re: [RFC PATCH 01/17] dax: refactor dax-fs into a generic provider of
 dax inodes
To: Christoph Hellwig <hch@lst.de>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-block@vger.kernel.org, jmoyer <jmoyer@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jan 30, 2017 at 4:28 AM, Christoph Hellwig <hch@lst.de> wrote:
> I really don't like the dax_inode name.  Why not something like
> dax_device or dax_region?

Fair enough, I'll switch struct dax_inode to dax_device and switch the
existing struct dax_dev to dax_info.
