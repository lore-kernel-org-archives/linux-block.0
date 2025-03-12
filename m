Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BE63595E;
	Wed, 12 Mar 2025 05:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741755645; cv=none; b=IYPFBeiBxVzn0+K8h9GgOGIOFBtHS3aTCREDxbb8PBoGhrHXPvTbTlfkFE/eWNKrLtJYcibJELlsmxJ5qfopiYrYWuNxhNvnBSKtL2X2YNPEAVavLJ9uwJ3TKbpZpbTr5Bf8pti+qIwqa43YCOW49CZXD2nXIIHeGAzss8TjzqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741755645; c=relaxed/simple;
	bh=gJD35K03DizHx1Ki+npAg0sP1R5X6WsLx/uI7xSKEnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KNiUUO/FTN4fXeTbeDq4Iq60UxFHV1AocX4R+kgFAPdYOOo+pLx2OyFY7/737j4qbOw4lDnlzKHUr9xytbrfIFo+AI47XDGQO5OMy0GLcMKyRO6QCVYfLBhqU00l9WqyZshDeEG/FZ7kuGA5yGlceH5/eJta95URARRm+bcWgCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PB1NraYK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PB1NraYK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A11BC4CEE3;
	Wed, 12 Mar 2025 05:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741755645;
	bh=gJD35K03DizHx1Ki+npAg0sP1R5X6WsLx/uI7xSKEnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PB1NraYK0kpGAyMdYcobXBiuXRsgcj3RuWTJDf3JKvNTE+rVQ0N+dNFPCPzCRFQ8M
	 M1e0DzBH6Pv38S1eBvkZWlZLaUfi+69OrvleQ7R9MXJGKx8AEB6jEdwBq/EEo2e+a8
	 FJKPY9DQkR9cCEvv0vLCtsiUJBJDs+vRNfXL3aZClsUCTgkGzbJQELiwZ23j2J+I84
	 9I5WZBtl18MslPwWUCJLuiRXrGhRg8M3jdccmlz1IyzonoaL0bsETyQCp9HQB14Qzq
	 FKSrmq2evdYcBfcRVtoKIL5nr3psWFjCL7u0nRbP/xetUk0pZMRApu6kyDuC2Qljt3
	 BXJ8/sS1VHVgQ==
Date: Tue, 11 Mar 2025 22:00:43 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Li Wang <liwang@redhat.com>
Cc: kernel test robot <oliver.sang@intel.com>,
	LTP List <ltp@lists.linux.it>,
	Christian Brauner <brauner@kernel.org>, 0day robot <lkp@intel.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
	oe-lkp@lists.linux.dev
Subject: Re: [LTP] [linux-next:master] [block/bdev] 47dd675323:
 ltp.ioctl_loop06.fail
Message-ID: <Z9EU-70DuwqFqD4p@bombadil.infradead.org>
References: <202503101538.84c33cd4-lkp@intel.com>
 <CAEemH2egF6ehr7B_5KDLuBQqoUJ5k7bVZkid-ERDBkxkChi7fw@mail.gmail.com>
 <CAB=NE6UWzyq+qXhGmpH2-6bePE+Zi=dJjBH7y3HeJnYyh6xvtw@mail.gmail.com>
 <CAEemH2c21vrSOKdJvHkyH+UOv-aXefXeFVZuv4-DSZ_P4Z3Mxw@mail.gmail.com>
 <Z8-tV0zJKP7wRAxK@bombadil.infradead.org>
 <CAEemH2d36bY-q-+P_vHKvj+kg6qi2k=y37PRNOr6mkY=pdFQrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEemH2d36bY-q-+P_vHKvj+kg6qi2k=y37PRNOr6mkY=pdFQrQ@mail.gmail.com>

On Tue, Mar 11, 2025 at 09:09:08PM +0800, Li Wang wrote:
> On Tue, Mar 11, 2025 at 11:33 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> > On Tue, Mar 11, 2025 at 09:43:42AM +0800, Li Wang wrote:
> > > On Mon, Mar 10, 2025 at 11:15 PM Luis Chamberlain <mcgrof@kernel.org>
> > wrote:
> > >
> > > > There's a fix for this already in next
> > > >
> > >
> > > Oh? Which commit?
> >
> > Oh seems linux-next hasn't been updated in a few days, so you can try
> > this patch:
> >
> > https://lore.kernel.org/all/20250307020403.3068567-1-mcgrof@kernel.org/
> 
> 
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -181,6 +181,8 @@ EXPORT_SYMBOL(set_blocksize);
> 
>  int sb_set_blocksize(struct super_block *sb, int size)
>  {
> +       if (!(sb->s_type->fs_flags & FS_LBS) && size > PAGE_SIZE)
> +               return 0;
>         if (set_blocksize(sb->s_bdev_file, size))
>                 return 0;
> ...
> 
> 
> Thanks, but looking at the code change, seems filesystems with FS_LBS
> (e.g., bcachefs, XFS) can still mount larger block sizes properly. IOW,
> the test ioctl_loop06 still failed on RHEL9 (XFS) platform.

The test does not fail because the filesystem being used, the test fails
because it expects setting the block size > PAGE_SIZE will fail for the
loop back device it is creating and then setting the block size for it.

There are two tests which fail:

  * set block size > PAGE_SIZE with LOOP_SET_BLOCK_SIZE
  * set block size > PAGE_SIZE with LOOP_CONFIGURE

It expects to fail. The new work enables the block layer to support
block sizes > PAGE_SIZE on block devices, essentially that the logical
or physical block size can be > PAGE_SIZE. That is supported now.

> Is that expected? Or, should we adjust the testcase for FS with FS_LBS
> as exception?

Contrary to filesystems, block drivers use now implicitly use
blk_validate_limits() through queue_limits_commit_update to validate
queue limits, but PAGE_SIZE is no longer an issue. In the loop back driver
case we have then:

ioctl LOOP_CONFIGURE --> loop_configure() 
	lim = queue_limits_start_update(lo->lo_queue);                           
	loop_update_limits(lo, &lim, config->block_size); 

ioctl LOOP_SET_BLOCK_SIZE --> loop_set_block_size()
	lim = queue_limits_start_update(lo->lo_queue);                           
	loop_update_limits(lo, &lim, arg); 

I don't see anything wrong with the loop driver supporting logical block
sizes > PAGE_SIZE, from a quick look, but it does not matter. If tests
exists which are verifying you *can't* do it, then we're bound to get
other similar reports. queue_limits_commit_update() calls
blk_validate_block_size. I just sent a fix.

Thanks for the report.

  Luis
