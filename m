Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752779AbdDLIsL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2017 04:48:11 -0400
Subject: Re: [PATCH 18/25] gfs2: Convert to properly refcounting bdi
To: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
References: <20170329105623.18241-1-jack@suse.cz>
 <20170329105623.18241-19-jack@suse.cz> <20170412081641.GR9830@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com
From: Steven Whitehouse <swhiteho@redhat.com>
Message-ID: <d6638e4f-13a8-a173-69ed-76d435327b93@redhat.com>
Date: Wed, 12 Apr 2017 09:48:05 +0100
MIME-Version: 1.0
In-Reply-To: <20170412081641.GR9830@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,


On 12/04/17 09:16, Christoph Hellwig wrote:
> On Wed, Mar 29, 2017 at 12:56:16PM +0200, Jan Kara wrote:
>> Similarly to set_bdev_super() GFS2 just used block device reference to
>> bdi. Convert it to properly getting bdi reference. The reference will
>> get automatically dropped on superblock destruction.
> Hmm, why iisn't gfs2 simply using the generic mount_bdev code?
>
> Otherwise looks fine:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

It is more or less. However we landed up copying it because we needed a 
slight modification in order to cope with the metafs mounts. There may 
be scope to factor out the common parts I guess. We cannot select the 
root dentry until after we've parsed the mount command line, so it is 
really just the last part of the function that is different,

Steve.
