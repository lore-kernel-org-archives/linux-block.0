Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253392EB847
	for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 13:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770902185; cv=none; b=ZK/bw+8CnXHnGj0R3itR1Sg6ABYsThNaYtxrCL02c89A3NCeOx05aw/bG9K0P+DRvJAzEOuByWQ1HAQlu1o3lvfyH5ZGum2bIHMnh+ZOnlOXY4rSo2gakHILEP23RgGld7aokyFAliVcMypplCDErIBE7UOoX6781TmeLHfNY0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770902185; c=relaxed/simple;
	bh=lpOcVsixQCpwYQC3pW3HVCkrtbY2RePlhCzKaGF9uUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZIqdLAlymWcQ/gQ56qBVsskt+krjVcTkCP9R1xIhwNNd68WWDYsD3Y6sb0IEUBzFNRf3LuQchk9ihN58h8XYxSBsD54miOsdJbiQCwZ0UaBwYN22N1FY/N0ICGDg5+7OtpVoc8x8JB7QEFxqJeyWrWm62x395Jo9nrM4xf1FCSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=Dw5MnHsL; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="Dw5MnHsL"
X-Virus-Scanned: Yes
Message-ID: <9e656591-a57c-474c-b3dd-8ee1f75ca9a7@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1770901699; bh=lpOcVsixQCpwYQC3pW3HVCkrtbY2RePlhCzKaGF9uUk=;
	h=Subject:To:References:From:In-Reply-To;
	b=Dw5MnHsLtBEryOD0E9t+zhe1oG+2p/tUx1NDiKpl0A+E2zYjnMIoolAMYaAHfgF4q
	 NnWLt+fFJg2/PjZdtC+7T1J8BOtDZQyTDcuiEOw1P+zGZdux9RmzWpEfQ8zvPIqH1F
	 etF4AERRaHcczHHANdNt1RlOYpJ27EWP2rcMs9FmelbKP1UD9B1ivGVcNKhUE/kKTh
	 guOk2CW6PaeZyMcZs1KI7f4j72ot3MKj95aRqUee/SQzvNTNB1xjBNG33SCPENXGF9
	 3X5enBss/uC+eyjC2rslIYAuzHtnTFpjd33cIIsoX37tprUiu0HfeNx7OmpL6P54jj
	 6OEDgyXIK7yXCFyozzEKp9CPitAkmrGVaZd3tNT4DbnFF2s1Q1DU853J3iiM+OgslE
	 9PCwsqFoz8HuyZjDROGcIv4/9bfCmZ/OWf8Xolmcw5mGs0RIKozzAHMg1+Ui97tuGP
	 K7mCKVWZacddWlhEo8TIWi/sHHQwGhpVvv+4mh7bgDxlF/tqz/qppnEM25FHrw2OFW
	 GrHvy0v5H1h450IP4QyPj65uuML3O88+6lZuVcyuzlG2GNv/0/EO7PwN90O5T6Bn3c
	 xABmhFvrLwevpKE7s1oE9n0+2jh2qMDetlhRalp7bWRdzoHVmMC/JIKtCQYByE5AO5
	 AwBtTbiOhhD9CkTrkXGwfDwY=
Date: Thu, 12 Feb 2026 15:08:17 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: ublk invert part scan bit logic
Content-Language: en-GB
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <0535f4dd-ada3-414a-84c6-7abc232aa670@kernel.dk>
From: Alexander Atanasov <alex@zazolabs.com>
In-Reply-To: <0535f4dd-ada3-414a-84c6-7abc232aa670@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 12.02.26 13:05, Jens Axboe wrote:
> Hi,
> 
> For ublk, there's this logic in in ublk_ctrl_start_dev():
> 
> /* Skip partition scan if disabled by user */
> if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
> 	clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> } else {
> 	/* Schedule async partition scan for trusted daemons */
> 	if (!ub->unprivileged_daemons)
> 		schedule_work(&ub->partition_scan_work);
> }
> 
> where the
> 
> clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> 
> seems reversed? Why is GD_SUPPRESS_PART_SCAN being cleared if
> UBLK_F_NO_AUTO_PART_SCAN is set? Added in:
> 
> 8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag")
> 

There is more to this :
a comment few lines above states that:
	 * For unprivileged daemons, keep GD_SUPPRESS_PART_SCAN set
	 * permanently.
	 */
	set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);

next in ublk_partition_scan_work it is
if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
it is not used anywhere else but at least for debug it is good to stay
and align with the comment.

So if i've untwisted it right:
do not clear the bit before scanning and invert logic to clear the
bit only(enable) scan only if UBLK_F_NO_AUTO_PART_SCAN is not requested
by the user for a trusted daemon.

Ming - what do you think?

-- 
have fun,
alex

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3c918db4905c..0d6d840b4f21 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2361,7 +2361,7 @@ static void ublk_partition_scan_work(struct 
work_struct *work)
         if (!disk)
                 return;

-       if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
+       if (WARN_ON_ONCE(test_bit(GD_SUPPRESS_PART_SCAN,
                                              &disk->state)))
                 goto out;

@@ -4429,13 +4429,13 @@ static int ublk_ctrl_start_dev(struct 
ublk_device *ub,

         set_bit(UB_STATE_USED, &ub->state);

-       /* Skip partition scan if disabled by user */
-       if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
+       /* Skip partition scan if disabled by user only for trusted 
daemons */
+       if (!ub->unprivileged_daemons &&
+           !(ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN)) {
+               /* Enable partition scanning */
                 clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
-       } else {
                 /* Schedule async partition scan for trusted daemons */
-               if (!ub->unprivileged_daemons)
-                       schedule_work(&ub->partition_scan_work);
+               schedule_work(&ub->partition_scan_work);
         }

  out_put_cdev:



