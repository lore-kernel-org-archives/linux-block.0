Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A78B665;
	Mon, 24 Nov 2025 02:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763950637; cv=none; b=gg8VCxOIh46gOHAqhg7TK0rTjFzkduaImZkonSK5wRjY+ORBoIdVwb3Jm55/klu7zHcxdz3W6CYM36T1VvK+X2c7EYSny8x859PhJLZAtElnVNA0r+IrzB8V71UDaIWQ44RRI4Ckb2GbsvGzTTMWmODos/drtsP9IhB4qB439U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763950637; c=relaxed/simple;
	bh=hoKyFBac0Hi02axSaC+uFfLbPtwQnZqMFqtTaSGbuvo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=NZcQL6UzBrG1SuwQgu7PHxy+Rri5nWLeNqirMNvytXzjgvZFw70RHdpU2tel66y9pHi3kUdXGNhHfgMVpbg8xdSvINgkyrEXCuNHnks/Lwr+xKGEaO8bEZq+Q1z4gAQGNP92sKTicQbliiZGJCSXTYyMAJxlnjZDsSgjYE4N24A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=mx9DbTTp; arc=none smtp.client-ip=43.163.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="mx9DbTTp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1763950626;
	bh=OEpCFJTxEykakEQhXdWAaRkM4i1m/KY/WMgpb4SGF2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mx9DbTTpQYC9kiEmAmH6uc2skzSWawJ0Uo7dZKtanXVKEnqt+UswgpyYL4JmbnE5X
	 67vRcANxDcRA+1ab+Xr2pjOQX8YIAYk6m1hgNU/x/jZG5k9kuJaGTryx2CM76SU6CD
	 mecqBiQM6Ip0wxFLyaGYEgQgwNB92kRhvsqjgDb0=
Received: from meizu-Precision-3660.meizu.com ([112.91.84.72])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 3F1A727C; Mon, 24 Nov 2025 10:15:49 +0800
X-QQ-mid: xmsmtpt1763950549tws4d5g73
Message-ID: <tencent_D7ED79431EC0D75957539121B7CC7897EB06@qq.com>
X-QQ-XMAILINFO: MhK4DKsBP06ii71TEOq87p7FvDy87u8ynN7Ft6iv+kVx9MZzpZ5FmND4pWYFHH
	 BGu7NCx9cQZMYOIVKjKa2hoMcTSKC92p84/T3CREAPd+AJv5LJ2FGcBkOSwmn3vbSVGTq5Dnlw05
	 EXye9Vzvw3rjGypXXG1Qjd2EfGsoT0mWHrU00oI6b1ZU30l3BhXRUcX7V6GJeSXEaEUkZRbx9nCV
	 iImtDkTScReJs0r5Eqiol1oTnJ19Y+ieszKJkmQT64q/0nscO8sNmkzAuOyKgH68Blirhk7SdS/L
	 70CO/5Hz3uxBKiQIP6brF077IxW+kTo+lnruf6o9XhJEJbAizTjz8eCRZdI/X42VnNaEDFeJnxwR
	 OcHmmHat/oNfq/IaNX1ZKCzbJVGyVfD5+2RhzKks58sIZraN0IB/jIC8PQI9zFGeBLs40fqSp+JD
	 L5vwCLIwbm0VipblWFn6aGHhQhnLa6j84I4NWriT3nvWbSH2sxS1bm0ytdxKXashakPswDTc8iOH
	 WvBzom/UOOxpGaLwgO3LJjcy0DYnlvq9Ts5wQzpyJb/ifPO5S0azVRNL/qQyW1Bm+LGoTjb8XqLm
	 HhxCEz3u0lsk5698Vz/ZfIaDoooJQ2rtYJqm07eXfszM2vHr26oOf958dzLgACfZgeuitXHOth8/
	 9Id2nWz/J0Nw2J8CPQLiLy5tTVqKRKRwFJdi6lrQ/Vbpu2L+hqNWwPVlQsT/cIfd6nP/EIJVcmRa
	 vTXiitx7Z3NM5frYe3Wa1l2fnYgJqldmtJjc9IXoQqvop3hpAy/DfAb74L2UtTETCDQjDbxUkCDX
	 vzW44OPDzmnolFQx4B/VcH2ZoLFzBstMlq/fmmFTDbtYOWdsbHNK/Y/hPkuUE690Q7+1+hAhXCLb
	 iEE7PJb6JcWi7TZkzyc7xHs6sLPqVkbMwUSxDM+S03qIf7J/DnAHTOf4/Ic0+6OPkyg0lUFGAFZV
	 Y1BYMHMeT8pfXwq0WciJtwsLvoQ4QrDJUsMJPIDCWbiKUe0RuWYEVFX4mDokSIBDKje4ZzJ1B8sN
	 jljy1fVnL037Ga8uoHP1GJ7B55HdH2aQ01pmvilA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: senozhatsky@chromium.org
Cc: akpm@linux-foundation.org,
	bgeffon@google.com,
	licayy@outlook.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@kernel.org,
	richardycc@google.com,
	ywen.chen@foxmail.com
Subject: 
Date: Mon, 24 Nov 2025 10:15:49 +0800
X-OQ-MSGID: <20251124021549.3636182-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <buckmtxvdfnpgo56owip3fjqbzraws2wvtomzfkywhczckoqlt@fifgyl5fjpbt>
References: <buckmtxvdfnpgo56owip3fjqbzraws2wvtomzfkywhczckoqlt@fifgyl5fjpbt>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: Re: [RFC PATCHv5 0/6] zram: introduce writeback bio batching

On Fri, 21 Nov 2025 18:12:29 +0900, Sergey Senozhatsky wrote:
> I had a version of the patch that had different main loop. It would
> always first complete finished requests.  I think this one will give
> accurate ->inflight number.

Using the following patch, the final measured result is 32. Using 32
here might be a relatively reasonable value.

 /* XXX: should be a per-device sysfs attr */
-#define ZRAM_WB_REQ_CNT 32
+#define ZRAM_WB_REQ_CNT 64
 
 static struct zram_wb_ctl *init_wb_ctl(void)
 {
@@ -983,6 +983,7 @@ static int zram_writeback_slots(struct zram *zram,
        struct zram_pp_slot *pps;
        int ret = 0, err = 0;
        u32 index = 0;
+       int inflight = 0;
 
        while ((pps = select_pp_slot(ctl))) {
                spin_lock(&zram->wb_limit_lock);
@@ -993,14 +994,10 @@ static int zram_writeback_slots(struct zram *zram,
                }
                spin_unlock(&zram->wb_limit_lock);
 
-               while (!req) {
-                       req = zram_select_idle_req(wb_ctl);
-                       if (req)
-                               break;
-
-                       wait_event(wb_ctl->done_wait,
-                                  !list_empty(&wb_ctl->done_reqs));
+               if (inflight < atomic_read(&wb_ctl->num_inflight))
+                       inflight = atomic_read(&wb_ctl->num_inflight);
 
+               while (!req) {
                        err = zram_complete_done_reqs(zram, wb_ctl);
                        /*
                         * BIO errors are not fatal, we continue and simply
@@ -1012,6 +1009,13 @@ static int zram_writeback_slots(struct zram *zram,
                         */
                        if (err)
                                ret = err;
+
+                       req = zram_select_idle_req(wb_ctl);
+                       if (req)
+                               break;
+
+                       wait_event(wb_ctl->done_wait,
+                                  !list_empty(&wb_ctl->done_reqs));
                }
 
                if (!blk_idx) {
@@ -1074,6 +1078,7 @@ next:
                        ret = err;
        }
 
+       pr_err("%s: inflight max: %d\n", __func__, inflight);
        return ret;

