Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F53C282CC
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 15:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A8F2077B
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 15:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="v7wRl+42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfBGPfL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:35:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35581 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGPfK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 10:35:10 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so99198plo.2
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 07:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=vfrucWasRxu8wXy8I+OWsttiphZ78Pxa89vVhirKE38=;
        b=v7wRl+42sRdc90Xr3bwo4dY+lG2m08Os2TWzjMUluAmfAXx53mYWdZk9xDGg4xBjPe
         phtFtdx9z2YZiuseCKwB6wNwa2/fqva9NyZ/nXkNtJdZkrPOwVxZqDxmIo7EDYTmH3Qq
         EfZciWgD188NKkDlMzfjm1CPZHfI3m7W3YENaMgUJ9FH2VmtbKk6zehcK6lMjIi8mU50
         03SS12dLlPCftTfVBHVWEfc7hYSNgDG9nxXsw24l4ylQkYFKvZ7/qiNoOuwpy+z58d7u
         U51cvcKmneEnevbHXoLNmee3w5yw8/Cv/Yx5uRByM2pPq3Omm2b0gH8pr4GItIQ84SfK
         aySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=vfrucWasRxu8wXy8I+OWsttiphZ78Pxa89vVhirKE38=;
        b=jOiI126cL3lbi1ZawibAnt4xqZtOHQ6cu1lb4ThjhFtpfMZQviXD968nxOUgCxKq1O
         nhm9MkQ8mJocjvAhkKSUJur+Ck2vORXQBB79K1nLT0K245b8AhYUw1A7TY6ICtNCfa8B
         OZWCA1/CkEzOX0Z2t5aNkVpjTQPlzbmOKx0mVY+wV5mrI5KsiEtKgafGNJdEuRAJHZpM
         q8v+yPEbHoYU7qw0rqUr8n17NP/ilHyNKaV+ME8KdKT4ayoVbHERlMwydNA1Ml31K/s4
         cJbm4lSHDTDdJy/ZOj2Ogn90UY7dm0l6RfyrOppJkx+3RnSlSqhnroO9dxcT9y11RP62
         I+2g==
X-Gm-Message-State: AHQUAuYsVW0eMFGqfS/hywRB0WJAC4zYvLO+AwyIcjRhBgMbhZQ0vqgz
        qHPcRLNoQf6a/qmUherijsQcwA==
X-Google-Smtp-Source: AHgI3IaVoMYYKhs8M27q2ZqhI+OfSw6Mv04jJk+GiXW7+JfxddzpCbSEEmMoiRDT4kfCHGPvz5JH/Q==
X-Received: by 2002:a17:902:7c8a:: with SMTP id y10mr16635068pll.71.1549553710158;
        Thu, 07 Feb 2019 07:35:10 -0800 (PST)
Received: from ?IPv6:2600:380:7712:367d:9d7:f8fb:d4f4:2531? ([2600:380:7712:367d:9d7:f8fb:d4f4:2531])
        by smtp.gmail.com with ESMTPSA id s2sm12302582pfa.167.2019.02.07.07.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 07:35:09 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: LSF/MM 2019: Call for Proposals (UPDATED!)
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        IDE/ATA development list <linux-ide@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>, bpf@vger.kernel.org,
        ast@kernel.org
Message-ID: <4f5a15c1-4f9e-acae-5094-2f38c8eebd96@kernel.dk>
Date:   Thu, 7 Feb 2019 08:35:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This is an important UPDATE to the previous LSF/MM announcement:

https://lore.kernel.org/linux-block/51b4b263-a0f2-113d-7bdc-f7960b540929@kernel.dk/

A BPF track will join the annual LSF/MM Summit this year! Please read
the updated description and CFP information below.

It will be held from April 30 - May 2 at the Sheraton Puerto Rico Hotel &
Casino Lodges in San Juan, Puerto Rico.
LSF/MM is an invitation-only technical workshop to map out improvements to
the Linux storage, filesystem, memory management, and bpf subsystems that
will make their way into the mainline kernel within the coming years.

https://events.linuxfoundation.org/events/linux-storage-filesystem-mm-summit-2019/

LSF/MM 2019 will be a three day, stand-alone conference with three
subsystem-specific tracks, cross-track discussions, as well as BoF and
hacking sessions.

On behalf of the committee I am issuing a call for agenda proposals
that are suitable for cross-track discussion as well as technical
subjects for the breakout sessions.

If advance notice is required for visa applications then please point
that out in your proposal or request to attend, and submit the topic
as soon as possible.

1) Proposals for agenda topics should be sent before February 22th,
2019 to:

	lsf-pc@lists.linux-foundation.org

and CC the mailing lists that are relevant for the topic in question:

	FS:	linux-fsdevel@vger.kernel.org
	MM:	linux-mm@kvack.org
	Block:	linux-block@vger.kernel.org
	ATA:	linux-ide@vger.kernel.org
	SCSI:	linux-scsi@vger.kernel.org
	NVMe:	linux-nvme@lists.infradead.org
        BPF:    bpf@vger.kernel.org

Note that we have extended the original deadline by a week, to
accommodate the late arrival of the BPF track.

Please tag your proposal with [LSF/MM TOPIC] to make it easier to
track. In addition, please make sure to start a new thread for each
topic rather than following up to an existing one. Agenda topics and
attendees will be selected by the program committee, but the final
agenda will be formed by consensus of the attendees on the day.

2) Requests to attend the summit for those that are not proposing a
topic should be sent to:

	lsf-pc@lists.linux-foundation.org

Please summarize what expertise you will bring to the meeting, and
what you would like to discuss. Please also tag your email with
[LSF/MM ATTEND] and send it as a new thread so there is less chance of
it getting lost.

We will try to cap attendance at around 25-30 per track to facilitate
discussions although the final numbers will depend on the room sizes
at the venue. Note that BPF track will be limited to 10-15 attendees.

For discussion leaders, slides and visualizations are encouraged to
outline the subject matter and focus the discussions. Please refrain
from lengthy presentations and talks; the sessions are supposed to be
interactive, inclusive discussions.

In particular BPF topics are encouraged to be storage, fs, mm, tracing,
security related or advancing the state of the art of BPF core.
BPF and networking related topics are recommended to be submitted for
Linux Plumbers Conference and corresponding Networking and BPF microconf
later this year.

Thank you on behalf of the program committee:

	Anna Schumaker (Filesystems)
	Josef Bacik (Filesystems)
	Martin K. Petersen (Storage)
	Jens Axboe (Storage)
	Michal Hocko (MM)
	Rik van Riel (MM)
	Johannes Weiner (MM)
        Alexei Starovoitov (BPF)

-- 
Jens Axboe

