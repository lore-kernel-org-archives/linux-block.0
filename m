Return-Path: <SRS0=ZBGg=V3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AA8C433FF
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 06:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DC420882
	for <linux-block@archiver.kernel.org>; Tue, 30 Jul 2019 06:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="42eqip90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfG3GVC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Jul 2019 02:21:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59680 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfG3GVC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Jul 2019 02:21:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6U6J3Xv053912;
        Tue, 30 Jul 2019 06:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=5n8OzrZ77RhnGg+5veAoaGbh8/tBKL2m5epcFu44MYY=;
 b=42eqip90AAbtzB6ZvgXhwkI8XAN/OPvcHZWvZpDlRDSyQ3Eo0whNMYnPKK+EVZXdKFqI
 Vp7VJpukJfhi00uVfoT3yYoxbdrCNyA17f71tQmkObzsmYMOC7XydFZRk+4dBCqleqED
 vilZteBonMT8gK0iiIXUmmz8+5GXnrDvKN0d2/J49xSCFqT0TLC9Iai7LQ9LJ690S3TN
 +TbTDBtpAF6xTWMKMns+MMPz3dORLffCZh4/PDkWAdm/rJwF7UfnKHEJjvdW+Csb5m3c
 T17T80i7nmSsp+ZUP7Auo9RV8QzLTs28eITV1UAqMq44Ag+ogSJOKAEMOrD0fImEl9Li LA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2u0e1tmap5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 06:20:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6U67pDb073545;
        Tue, 30 Jul 2019 06:20:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2u0ee4u69w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 06:20:38 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6U6KbGR031036;
        Tue, 30 Jul 2019 06:20:37 GMT
Received: from [192.168.1.24] (/180.169.93.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jul 2019 23:20:37 -0700
Subject: Re: [PATCH 1/2] md/raid0: Introduce new array state 'broken' for
 raid0
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-raid@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        jay.vosburgh@canonical.com, neilb@suse.com, songliubraving@fb.com
References: <20190729203135.12934-1-gpiccoli@canonical.com>
 <20190729203135.12934-2-gpiccoli@canonical.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <d730c417-a328-3df3-1e31-32b6df48b6ad@oracle.com>
Date:   Tue, 30 Jul 2019 14:20:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190729203135.12934-2-gpiccoli@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907300065
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9333 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907300066
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/30/19 4:31 AM, Guilherme G. Piccoli wrote:
> Currently if a md/raid0 array gets one or more members removed while
> being mounted, kernel keeps showing state 'clean' in the 'array_state'
> sysfs attribute. Despite udev signaling the member device is gone, 'mdadm'
> cannot issue the STOP_ARRAY ioctl successfully, given the array is mounted.
> 
> Nothing else hints that something is wrong (except that the removed devices
> don't show properly in the output of 'mdadm detail' command). There is no
> other property to be checked, and if user is not performing reads/writes
> to the array, even kernel log is quiet and doesn't give a clue about the
> missing member.
> 
> This patch changes this behavior; when 'array_state' is read we introduce
> a non-expensive check (only for raid0) that relies in the comparison of
> the total number of disks when array was assembled with gendisk flags of> those devices to validate if all members are available and functional.
> A new array state 'broken' was added: it mimics the state 'clean' in every
> aspect, being useful only to distinguish if such array has some member
> missing. Also, we show a rate-limited warning in kernel log in such case.
> 
> This patch has no proper functional change other than adding a 'clean'-like
> state; it was tested with ext4 and xfs filesystems. It requires a 'mdadm'
> counterpart to handle the 'broken' state.
> 
> Cc: NeilBrown <neilb@suse.com>
> Cc: Song Liu <songliubraving@fb.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
> ---
>  drivers/md/md.c    | 23 +++++++++++++++++++----
>  drivers/md/md.h    |  2 ++
>  drivers/md/raid0.c | 26 ++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index fba49918d591..b80f36084ec1 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -4160,12 +4160,18 @@ __ATTR_PREALLOC(resync_start, S_IRUGO|S_IWUSR,
>   * active-idle
>   *     like active, but no writes have been seen for a while (100msec).
>   *
> + * broken
> + *     RAID0-only: same as clean, but array is missing a member.
> + *     It's useful because RAID0 mounted-arrays aren't stopped
> + *     when a member is gone, so this state will at least alert
> + *     the user that something is wrong.


Curious why only raid0 has this issue? 

Thanks, -Bob

> + *
>   */
>  enum array_state { clear, inactive, suspended, readonly, read_auto, clean, active,
> -		   write_pending, active_idle, bad_word};
> +		   write_pending, active_idle, broken, bad_word};
>  static char *array_states[] = {
>  	"clear", "inactive", "suspended", "readonly", "read-auto", "clean", "active",
> -	"write-pending", "active-idle", NULL };
> +	"write-pending", "active-idle", "broken", NULL };
>  
>  static int match_word(const char *word, char **list)
>  {
> @@ -4181,7 +4187,7 @@ array_state_show(struct mddev *mddev, char *page)
>  {
>  	enum array_state st = inactive;
>  
> -	if (mddev->pers)
> +	if (mddev->pers) {
>  		switch(mddev->ro) {
>  		case 1:
>  			st = readonly;
> @@ -4201,7 +4207,15 @@ array_state_show(struct mddev *mddev, char *page)
>  				st = active;
>  			spin_unlock(&mddev->lock);
>  		}
> -	else {
> +
> +		if ((mddev->pers->level == 0) &&
> +		   ((st == clean) || (st == broken))) {
> +			if (mddev->pers->is_missing_dev(mddev))
> +				st = broken;
> +			else
> +				st = clean;
> +		}
> +	} else {
>  		if (list_empty(&mddev->disks) &&
>  		    mddev->raid_disks == 0 &&
>  		    mddev->dev_sectors == 0)
> @@ -4315,6 +4329,7 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
>  		break;
>  	case write_pending:
>  	case active_idle:
> +	case broken:
>  		/* these cannot be set */
>  		break;
>  	}
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 41552e615c4c..e7b42b75701a 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -590,6 +590,8 @@ struct md_personality
>  	int (*congested)(struct mddev *mddev, int bits);
>  	/* Changes the consistency policy of an active array. */
>  	int (*change_consistency_policy)(struct mddev *mddev, const char *buf);
> +	/* Check if there is any missing/failed members - RAID0 only for now. */
> +	bool (*is_missing_dev)(struct mddev *mddev);
>  };
>  
>  struct md_sysfs_entry {
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index 58a9cc5193bf..79618a6ae31a 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -455,6 +455,31 @@ static inline int is_io_in_chunk_boundary(struct mddev *mddev,
>  	}
>  }
>  
> +bool raid0_is_missing_dev(struct mddev *mddev)
> +{
> +	struct md_rdev *rdev;
> +	static int already_missing;
> +	int def_disks, work_disks = 0;
> +	struct r0conf *conf = mddev->private;
> +
> +	def_disks = conf->strip_zone[0].nb_dev;
> +	rdev_for_each(rdev, mddev)
> +		if (rdev->bdev->bd_disk->flags & GENHD_FL_UP)
> +			work_disks++;
> +
> +	if (unlikely(def_disks - work_disks)) {
> +		if (!already_missing) {
> +			already_missing = 1;
> +			pr_warn("md: %s: raid0 array has %d missing/failed members\n",
> +				mdname(mddev), (def_disks - work_disks));
> +		}
> +		return true;
> +	}
> +
> +	already_missing = 0;
> +	return false;
> +}
> +
>  static void raid0_handle_discard(struct mddev *mddev, struct bio *bio)
>  {
>  	struct r0conf *conf = mddev->private;
> @@ -789,6 +814,7 @@ static struct md_personality raid0_personality=
>  	.takeover	= raid0_takeover,
>  	.quiesce	= raid0_quiesce,
>  	.congested	= raid0_congested,
> +	.is_missing_dev	= raid0_is_missing_dev,
>  };
>  
>  static int __init raid0_init (void)
> 

