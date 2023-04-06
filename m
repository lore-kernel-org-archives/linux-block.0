Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759CBC76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 06:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjDFGRl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 02:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbjDFGRj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 02:17:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02F78A51
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 23:17:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 684711FF43;
        Thu,  6 Apr 2023 06:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680761856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PI0V3VGiW12lvl/2LJ14W4Dt1wz1QsN+t9i8GNG9b84=;
        b=mHn2Y6jdhOl3r2V5EnJqaugIdklM87zj7QmmOudwP958oVxhuAQWmnHo0JdO+Ww18McXfi
        O9chc8UV+RtuPPQKmnr6+7SJuER0hwG/A0fRqbb9bV9b9Vf9v92re/0UAn+woZCZM8HMPP
        oQb5Hyd8Q/DxehtsMyH8wEdHI8Xv83E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680761856;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PI0V3VGiW12lvl/2LJ14W4Dt1wz1QsN+t9i8GNG9b84=;
        b=n8s/HeoJQZk2Y5KuICNyOIqYozsUridAb4wV1ecEvz8ssLyNR9QDFNtOFjNVCLEIINHKQS
        wWN5PZ/GJ8/HmwCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 581D8133E5;
        Thu,  6 Apr 2023 06:17:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QmUKFQBkLmQSIwAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 06 Apr 2023 06:17:36 +0000
Date:   Thu, 6 Apr 2023 08:17:35 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v5 4/4] nvme/048: test queue count changes on
 reconnect
Message-ID: <lgqrsky6qbdiyhnzunc453mpbgxvr4fi5fumpi6xrhvd3lfgvf@vakvam7bkerx>
References: <20230405154630.16298-1-dwagner@suse.de>
 <20230405154630.16298-5-dwagner@suse.de>
 <b469de5e-0005-b123-8473-6b95661e78d7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b469de5e-0005-b123-8473-6b95661e78d7@nvidia.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 05, 2023 at 06:57:49PM +0000, Chaitanya Kulkarni wrote:
> 
> > +	if ! _detect_nvmet_subsys_attr "attr_qid_max"; then
> > +		SKIP_REASONS+=("missing attr_qid_max feature")
> > +		return 1
> > +	fi
> > +
> > +	truncate -s 512M "${file_path}"
> > +
> > +	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
> > +		"b92842df-a394-44b1-84a4-92ae7d112861"
> 
> by checking following after create subsystem in testcase itself
> we avoid whole process of creating and deleting subsystem and
> additional function in the rc file, because we are already creating
> subsystem as a part of the testcase :-
> 
> local attr="${NVMET_CFS}/subsystems/${subsys_name}/attr_qid_max"
> 
> #above tow vars go top of this function
> 
> if [ -f "${attr}" ];then
>      SKIP_REASONS+=("missing attr_qid_max feature")
>      #do appropriate error handling and jump to unwind code
> fi
> 
> again please ignore this comment if decision has been made to
> keep it this way for some reason...

Again, no decision here. I think I overengineered this part slightly. Indeed if
we are goint to setup a controller anyway we should try to avoid double work.
This should also speed up the test slightly.

Talking about execution time, I was thinking on reducing the timeout value
to reduce the overall runtime.
