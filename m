Return-Path: <SRS0=q0Gp=XF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D20C3A5A2
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 12:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC972084D
	for <linux-block@archiver.kernel.org>; Tue, 10 Sep 2019 12:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="FH3GKWCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfIJMlT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Sep 2019 08:41:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45349 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfIJMlT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Sep 2019 08:41:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id f19so16892353eds.12
        for <linux-block@vger.kernel.org>; Tue, 10 Sep 2019 05:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GwNRqeM13az+GcMZuk5D7SOpEAEzVGe5sOO8sU8b1O0=;
        b=FH3GKWCJHv4dbmW7CL4sLdXxpTqJvplAvSWjgkjBTqRcOfcMVE07GL3Jp6EXPkWObs
         OhpGqXI08Qyte2VT35YgevL8dQHawtrzj9dqckvs3YkveGXBsW+I1s7PhLPdsbF5veYT
         d1ZFSOLMUerVSwDtnWwGSg14XkCvkEm1KwyfuNZGCpXsR2k69LkMl9xX2Vh92ohh3L8k
         OWqc//lK0SaJrIoIrMQ8iUtGclXmi8hStFDxoW5sIes3+0ACAZJBCxe3p/NKkOCtwU+j
         uMN20uB1R2CbHKAsWo5L2GBGOqt1A3wxLhjstfaiKRAQU9pjO55ZzG3y172GgH/CCsuP
         d5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GwNRqeM13az+GcMZuk5D7SOpEAEzVGe5sOO8sU8b1O0=;
        b=TKR7PABeqO/KY1Or6NxFUNPJ1WPp9FrdeTCSbjj6mZTz/EpLY+mGiCGZeOUCWQ56kv
         2FgX6Ftm3KVpHSB/ZI5vYu8cKhvbz7ZJIITBX0/BPKWPXsQRdr8CyNesONUBrlxdDG18
         agiQPlifAPSsD29rps9GT9GeIChd0W7+/jvUIqx+v2w6P3dSb8kLUTKWpy4xyA64lZ8k
         m/XUYwdSx5BOaDj7jD/43FU38oI8sz8PDltFcNMviNJ11O7clQ2IaF7ZvqeWJvcKCGmx
         cuxofwxzHAH8Z6RR8QXb9yQiCIQeOBMXXIGGFahozJTuTYLAH2ZBzUUBGF57crpiZGMd
         0YCg==
X-Gm-Message-State: APjAAAW9etm3mtXwtNCtploTNC6fA2NKQ1P0Ejf68eu29gl3Rs4akb0W
        KbW4GtCgZ5A4ULOxmbB4TSJpqwKhr0Hc7w==
X-Google-Smtp-Source: APXvYqzuZgAHFrWqq7g8NqYtE0SzsuyxG3p4fkXOYP0tzC5VILuTTCWuFFdE0KcMASDmA6hYAPYOzQ==
X-Received: by 2002:a17:906:80cd:: with SMTP id a13mr24990928ejx.155.1568119277429;
        Tue, 10 Sep 2019 05:41:17 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r23sm3539334edx.1.2019.09.10.05.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2019 05:41:16 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 913A410416F; Tue, 10 Sep 2019 15:41:16 +0300 (+03)
Date:   Tue, 10 Sep 2019 15:41:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Mike Christie <mchristi@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [RFC PATCH] Add proc interface to set PF_MEMALLOC flags
Message-ID: <20190910124116.74pxl73rybmkl5j3@box>
References: <20190909162804.5694-1-mchristi@redhat.com>
 <20190910100000.mcik63ot6o3dyzjv@box.shutemov.name>
 <DM6PR04MB5817096434DE9381DDB55184E7B60@DM6PR04MB5817.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB5817096434DE9381DDB55184E7B60@DM6PR04MB5817.namprd04.prod.outlook.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 10, 2019 at 12:05:33PM +0000, Damien Le Moal wrote:
> On 2019/09/10 11:00, Kirill A. Shutemov wrote:
> > On Mon, Sep 09, 2019 at 11:28:04AM -0500, Mike Christie wrote:
> >> There are several storage drivers like dm-multipath, iscsi, and nbd that
> >> have userspace components that can run in the IO path. For example,
> >> iscsi and nbd's userspace deamons may need to recreate a socket and/or
> >> send IO on it, and dm-multipath's daemon multipathd may need to send IO
> >> to figure out the state of paths and re-set them up.
> >>
> >> In the kernel these drivers have access to GFP_NOIO/GFP_NOFS and the
> >> memalloc_*_save/restore functions to control the allocation behavior,
> >> but for userspace we would end up hitting a allocation that ended up
> >> writing data back to the same device we are trying to allocate for.
> >>
> >> This patch allows the userspace deamon to set the PF_MEMALLOC* flags
> >> through procfs. It currently only supports PF_MEMALLOC_NOIO, but
> >> depending on what other drivers and userspace file systems need, for
> >> the final version I can add the other flags for that file or do a file
> >> per flag or just do a memalloc_noio file.
> >>
> >> Signed-off-by: Mike Christie <mchristi@redhat.com>
> >> ---
> >>  Documentation/filesystems/proc.txt |  6 ++++
> >>  fs/proc/base.c                     | 53 ++++++++++++++++++++++++++++++
> >>  2 files changed, 59 insertions(+)
> >>
> >> diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
> >> index 99ca040e3f90..b5456a61a013 100644
> >> --- a/Documentation/filesystems/proc.txt
> >> +++ b/Documentation/filesystems/proc.txt
> >> @@ -46,6 +46,7 @@ Table of Contents
> >>    3.10  /proc/<pid>/timerslack_ns - Task timerslack value
> >>    3.11	/proc/<pid>/patch_state - Livepatch patch operation state
> >>    3.12	/proc/<pid>/arch_status - Task architecture specific information
> >> +  3.13  /proc/<pid>/memalloc - Control task's memory reclaim behavior
> >>  
> >>    4	Configuring procfs
> >>    4.1	Mount options
> >> @@ -1980,6 +1981,11 @@ Example
> >>   $ cat /proc/6753/arch_status
> >>   AVX512_elapsed_ms:      8
> >>  
> >> +3.13 /proc/<pid>/memalloc - Control task's memory reclaim behavior
> >> +-----------------------------------------------------------------------
> >> +A value of "noio" indicates that when a task allocates memory it will not
> >> +reclaim memory that requires starting phisical IO.
> >> +
> >>  Description
> >>  -----------
> >>  
> >> diff --git a/fs/proc/base.c b/fs/proc/base.c
> >> index ebea9501afb8..c4faa3464602 100644
> >> --- a/fs/proc/base.c
> >> +++ b/fs/proc/base.c
> >> @@ -1223,6 +1223,57 @@ static const struct file_operations proc_oom_score_adj_operations = {
> >>  	.llseek		= default_llseek,
> >>  };
> >>  
> >> +static ssize_t memalloc_read(struct file *file, char __user *buf, size_t count,
> >> +			     loff_t *ppos)
> >> +{
> >> +	struct task_struct *task;
> >> +	ssize_t rc = 0;
> >> +
> >> +	task = get_proc_task(file_inode(file));
> >> +	if (!task)
> >> +		return -ESRCH;
> >> +
> >> +	if (task->flags & PF_MEMALLOC_NOIO)
> >> +		rc = simple_read_from_buffer(buf, count, ppos, "noio", 4);
> >> +	put_task_struct(task);
> >> +	return rc;
> >> +}
> >> +
> >> +static ssize_t memalloc_write(struct file *file, const char __user *buf,
> >> +			      size_t count, loff_t *ppos)
> >> +{
> >> +	struct task_struct *task;
> >> +	char buffer[5];
> >> +	int rc = count;
> >> +
> >> +	memset(buffer, 0, sizeof(buffer));
> >> +	if (count != sizeof(buffer) - 1)
> >> +		return -EINVAL;
> >> +
> >> +	if (copy_from_user(buffer, buf, count))
> >> +		return -EFAULT;
> >> +	buffer[count] = '\0';
> >> +
> >> +	task = get_proc_task(file_inode(file));
> >> +	if (!task)
> >> +		return -ESRCH;
> >> +
> >> +	if (!strcmp(buffer, "noio")) {
> >> +		task->flags |= PF_MEMALLOC_NOIO;
> >> +	} else {
> >> +		rc = -EINVAL;
> >> +	}
> > 
> > Really? Without any privilege check? So any random user can tap into
> > __GFP_NOIO allocations?
> 
> OK. It probably should have a test on capable(CAP_SYS_ADMIN) or similar. Since
> these storage daemons are generally run as root anyway, that would still work
> for most setup I think.
> 
> > 
> > NAK.
> > 
> > I don't think that it's great idea in general to expose this low-level
> > machinery to userspace. But it's better to get comment from people move
> > familiar with reclaim path.
> 
> Any setup with stacked file systems and one of the IO path component being a
> user level process can benefit from this. See the problem described in this
> patch I pushed for (unsuccessfully as it was a heavy handed solution):
> https://www.spinics.net/lists/linux-fsdevel/msg148912.html
> 
> As the discussion in this thread shows, there is no existing simple solution to
> deal with this reclaim recursion problem. And automatic detection is too hard,
> if at all possible. With the proper access rights added, this user accessible
> interface does look very sensible to me.

Looking into the thread, have you find out if there's anything on FUSE
side that helps it to avoid deadlocks? Or FUSE just relies on luck with
this?

-- 
 Kirill A. Shutemov
