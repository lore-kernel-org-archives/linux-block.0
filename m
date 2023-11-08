Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376B8DDC2
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 09:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVrf6U/E"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FDE1B1
	for <linux-block@vger.kernel.org>; Wed,  8 Nov 2023 01:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699434490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bHDawh8TcffRw8jNLFsmTf7XWpj9YVQC6Fj3ofPE7uo=;
	b=PVrf6U/EDbBwqILbTuWmEtftrIaLJVIpfzcGMLDYspi/e2WdmCX2mu9FIQWi6753yJS+wT
	8v8qeZ2UMhZIAN0HSe6kYcYritUGtAkywwjhAZDMYQWlsYK3wfICRFf9+k3NF2OH8EzTWJ
	oqpr9KiAyqppEQmtVl9sPhIkzFRo2Wg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-108-yM-zH7uBOu6hATO1bi78yg-1; Wed,
 08 Nov 2023 04:08:06 -0500
X-MC-Unique: yM-zH7uBOu6hATO1bi78yg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10EDC38143A2;
	Wed,  8 Nov 2023 09:08:06 +0000 (UTC)
Received: from fedora (unknown [10.72.120.7])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F376E25C1;
	Wed,  8 Nov 2023 09:08:03 +0000 (UTC)
Date: Wed, 8 Nov 2023 17:07:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] ublk/rc: prefer to rublk over miniublk
Message-ID: <ZUtP76DdikBTiBLs@fedora>
References: <20231106003523.1923694-1-ming.lei@redhat.com>
 <snthk6n6lo6767rjxj7xeevgbebxjqzxhwouacqr3335l4xat3@hv4zaukbl6dy>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <snthk6n6lo6767rjxj7xeevgbebxjqzxhwouacqr3335l4xat3@hv4zaukbl6dy>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Hi Shinichiro,

On Tue, Nov 07, 2023 at 05:28:59AM +0000, Shinichiro Kawasaki wrote:
> On Nov 06, 2023 / 08:35, Ming Lei wrote:
> > Add one wrapper script for using rublk to run ublk tests, and prefer
> > to rublk because it is well implemented and more reliable.
> > 
> > This way has been run for months in rublk's github CI test.
> > 
> > https://github.com/ming1/rublk
> > 
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> Hi Ming, it sounds good to shift from miniublk to rublk to reduce maintenance
> work of src/miniublk. I tried the patch, and found a couple of points to
> improve.
> 
> 1) The issue that Akinobu addressed with the commit 880fb6afff2e is observed
>    with rublk. I did the command lines below which were noted in his commit:
> 
>     $ modprobe -r scsi_debug
>     $ modprobe scsi_debug sector_size=4096 dev_size_mb=2048
>     $ mkfs.ext4 /dev/sdX
>     $ mount /dev/sdX results/
>     $ ./check ublk/003
> 
>   Then I observed the failure:
> 
> ublk/003 (test mounting block device exported by ublk)       [failed]
>     runtime  0.529s  ...  0.465s
>     --- tests/ublk/003.out      2023-09-05 10:05:11.292889193 +0900
>     +++ /home/shin/Blktests/blktests/results/nodev/ublk/003.out.bad     2023-11-07 14:18:44.966654288 +0900
>     @@ -1,2 +1,3 @@
>      Running ublk/003
>     +got , should be ext4
>      Test complete
> 
>   So I guess rublk needs a similar fix as Akinobu did for miniublk.

Indeed, rublk-loop just takes default 512B as block size, and will fix
it in v0.1.3, which also supports to specify logical/physical block size
from command line, and I will add one test case in blktests later.

> 
> 
> 2) I ran shellcheck for src/rublk_wrapper.sh and observed two meesages:
> 
>     src/rublk_wrapper.sh:10:12: error: Double quote array expansions to avoid re-splitting elements. [SC2068]
>     src/rublk_wrapper.sh:32:7: note: Double quote to prevent globbing and word splitting. [SC2086]
> 
> I suggest to apply changes below to make the script a bit more robust.

Good catch, thanks for the improvement, and I will integrate it into
next version.



Thanks,
Ming

