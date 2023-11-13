Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC2422EE3
	for <linux-block@vger.kernel.org>; Mon, 13 Nov 2023 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSRdHj5D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05906DB
	for <linux-block@vger.kernel.org>; Mon, 13 Nov 2023 09:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699898299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RPF52YGKE4Om8B5MFnlV0OhBSkjH3UnR44+aa/CcIB0=;
	b=RSRdHj5DyFUbRXf9XrQIzSUUGiT54uDMNvwP4IiMPEj8ow4FWsPQmaX+daEYwmFPZJgbG5
	6yFYYFALSisHqZjhY4Mw53YEt1nwEvEtGGxiQrAflUOpwSEfoXgBNtKVXjMMtKeVLxy/uo
	ZscewVJkGvOy9gc/VWhxDlHYRtTnBEw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-Tn-lIhH3P3WZ5o-pYFzeNw-1; Mon, 13 Nov 2023 12:58:16 -0500
X-MC-Unique: Tn-lIhH3P3WZ5o-pYFzeNw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CBE28007B3;
	Mon, 13 Nov 2023 17:58:15 +0000 (UTC)
Received: from rhel-developer-toolbox (unknown [10.2.16.152])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BE5B62166B26;
	Mon, 13 Nov 2023 17:58:14 +0000 (UTC)
Date: Mon, 13 Nov 2023 09:58:12 -0800
From: Chris Leech <cleech@redhat.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Keith Busch <kbusch@kernel.org>,
	Maurizio Lombardi <mlombard@redhat.com>
Subject: Re: [bug report][bisected] nvme authentication setup failed observed
 during blktests nvme/041 nvme/042 nvme/043
Message-ID: <ZVJjtOGpulFV61ii@rhel-developer-toolbox>
References: <CAHj4cs8yZ4-BXqTK4W0UsPpmc2ctCD=_mYiwuAuvcmgS3+KJ8g@mail.gmail.com>
 <CAHj4cs8vqrePA-TE_GGNAZLG3iqZBq9L1GkanA4A0wRF_TXDeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHj4cs8vqrePA-TE_GGNAZLG3iqZBq9L1GkanA4A0wRF_TXDeA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Hi Yi Zhang,

Where is your kernel configuration coming from?  If it's carried forward
from an older kernel, it may have the NVME_AUTH symbol set but not
NVME_HOST_AUTH.  That would now just enabled the shared host/target core
auth code, but not the host support.  I think updating your kernel
config to include NVME_HOST_AUTH will fix this.

- Chris

On Thu, Oct 19, 2023 at 03:16:13PM +0800, Yi Zhang wrote:
> Hi Hanns
> 
> Bisect shows it was introduced with this commit.
> 
> commit d680063482885c15d68e958212c3d6ad40a510dd (HEAD)
> Author: Hannes Reinecke <hare@suse.de>
> Date:   Thu Oct 12 14:22:48 2023 +0200
> 
>     nvme: rework NVME_AUTH Kconfig selection
> 
>     Having a single Kconfig symbol NVME_AUTH conflates the selection
>     of the authentication functions from nvme/common and nvme/host,
>     causing kbuild robot to complain when building the nvme target
>     only. So introduce a Kconfig symbol NVME_HOST_AUTH for the nvme
>     host bits and use NVME_AUTH for the common functions only.
>     And move the CRYPTO selection into nvme/common to make it
>     easier to read.
> 
> On Wed, Oct 18, 2023 at 2:57 PM Yi Zhang <yi.zhang@redhat.com> wrote:
> >
> > Hello
> > Just found the blktests nvme/041 nvme/042 nvme/043[2] failed on the
> > latest linux-block/for-next[1],
> > from the log I can see it was due to authentication setup failed,
> > please help check it, thanks.
> >
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/log/?h=for-next
> > e3db512c4ab6 (HEAD -> for-next, origin/for-next) Merge branch
> > 'for-6.7/block' into for-next
> >
> > [2]
> > # ./check nvme/041
> > nvme/041 (Create authenticated connections)                  [failed]
> >     runtime  3.274s  ...  3.980s
> >     --- tests/nvme/041.out      2023-10-17 08:02:17.046653814 -0400
> >     +++ /root/blktests/results/nodev/nvme/041.out.bad   2023-10-18
> > 02:50:03.496539083 -0400
> >     @@ -2,5 +2,5 @@
> >      Test unauthenticated connection (should fail)
> >      NQN:blktests-subsystem-1 disconnected 0 controller(s)
> >      Test authenticated connection
> >     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
> >     +NQN:blktests-subsystem-1 disconnected 0 controller(s)
> >      Test complete
> >
> > # dmesg
> > [ 2701.636964] loop: module loaded
> > [ 2702.074262] run blktests nvme/041 at 2023-10-18 02:49:59
> > [ 2702.302067] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > [ 2702.447496] nvmet: creating nvm controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> > with DH-HMAC-CHAP.
> > [ 2702.447707] nvme nvme0: qid 0: authentication setup failed
> > [ 2704.099618] nvmet: creating nvm controller 1 for subsystem
> > blktests-subsystem-1 for NQN
> > nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> > with DH-HMAC-CHAP.
> > [ 2704.099688] nvme nvme0: qid 0: authentication setup failed
> >
> >
> > --
> > Best Regards,
> >   Yi Zhang
> 
> 
> 
> -- 
> Best Regards,
>   Yi Zhang
> 

