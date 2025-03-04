Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E631EFF9F
	for <linux-block@vger.kernel.org>; Tue,  4 Mar 2025 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082539; cv=none; b=WVsI1vxd2hvoqn80paIEq+7mIAIsg3ZXevfhyNI3JQNcSrr2dgISgEBbyLarJo5ekORearHJvnm0l3qfssMo+XtphKjDtEAVL5jcw1dFiLDHwN1OWOfObGXJ4+A8ikEJVsJD3CKi5F00YsOjQiIVy//1coWvg1lzYifk99z/mtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082539; c=relaxed/simple;
	bh=5+HmuCsJLzbNGBotLifin9bpBqygwQfTvMH5l2Y3BEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7unJlOU9OZl6G60/tpChmIs7x8dC+RZMYflpTQcQzjiiq/k/Jq3KpsDMa5rNCz7xiDnYsb/cxu1DqZ+s8jXGX6OPJTPak4xH7AMrgJaUuvl46pe+Gr7wn7ip9hVeZec2Kt9/4qliCZ10bNCp2ETYtQ3KVmMHTSE4baHuL6RmQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZOMEaA06; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZOMEaA06"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741082536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xt2MKxhIpaJ7L1fZbHEGyuWMsDMBEPy8r6XBuZn5aXM=;
	b=ZOMEaA068ngSBBCTUrJB2nTU9ryurBia3Bar9oVLQkTqSHnSOcKv0LUrVN0Waq8mw9OsDu
	GhQPszKPtTpXZ8/NoWURKAKrpvFjuIAaHCO9Led0gE1pX72fN7g7lD53W0uezsib5m4FbK
	6D3VGwk7U6S7rrbQOvQlr9Dvzbq/VgQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-m7MqAFBXNaGQ9xsuk3jfHQ-1; Tue,
 04 Mar 2025 05:02:15 -0500
X-MC-Unique: m7MqAFBXNaGQ9xsuk3jfHQ-1
X-Mimecast-MFC-AGG-ID: m7MqAFBXNaGQ9xsuk3jfHQ_1741082534
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C883180098C;
	Tue,  4 Mar 2025 10:02:13 +0000 (UTC)
Received: from fedora (unknown [10.72.120.29])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 039AE180087C;
	Tue,  4 Mar 2025 10:02:09 +0000 (UTC)
Date: Tue, 4 Mar 2025 18:02:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] tests/throtl: add a new test 006
Message-ID: <Z8bPm44sMy88l0yL@fedora>
References: <20250224095945.1994997-1-ming.lei@redhat.com>
 <94ad8a55-97a7-d75a-7cfd-08cbce159bed@huaweicloud.com>
 <CAFj5m9KZqaVb_ZGgtdHxNxpuccuBcAVxcYOxaTGkuvuAQSf5Xw@mail.gmail.com>
 <d0013f94-65a0-684f-6122-d8e98eb3e9bf@huaweicloud.com>
 <7ff7166f-3069-59ae-6820-98e8b76057d6@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ff7166f-3069-59ae-6820-98e8b76057d6@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Mar 04, 2025 at 10:46:40AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/02/25 10:07, Yu Kuai 写道:
> > Hi,
> > 
> > 在 2025/02/24 21:54, Ming Lei 写道:
> > > > Do you run this test without the kernel patch? If I remembered
> > > > correctly, ext4 issue the meta IO from jbd2 by default, which is from
> > > > root cgroup, and root cgroup can only throttled from cgroup v1.
> > > It passes on v6.14-rc1, does META/SWAP IO only route from cgroup v1?
> > 
> > Of course not, it's just ext4 will issue such IO from root cgroup, and
> > there is no IO can be throttled here.
> > 
> > You might want to bind jbd2 to the test cgroup as well.

But the issue still can't be reproduced by adding the following delta
change, meantime revert 29390bb5661d ("blk-throttle: support prioritized
processing of metadata") on kernel side.

diff --git a/tests/throtl/006 b/tests/throtl/006
index 4baadaf..bb09eb2 100755
--- a/tests/throtl/006
+++ b/tests/throtl/006
@@ -43,7 +43,11 @@ test() {

        _throtl_set_limits wbps=$((1024 * 1024))
        {
+               local jbd2_pid
+
+               jbd2_pid=$(ps -eo pid,comm |grep "jbd2/${THROTL_DEV}" |awk '{print $1}')
                echo "$BASHPID" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
+               echo "$jbd2_pid" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
                _throtl_issue_fs_io  "${TMPDIR}/mnt/test.img" write 64K 64 &
                sleep 2
                test_meta_io "${TMPDIR}/mnt"


Thanks,
Ming

