Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8818F1AA794
	for <linux-block@vger.kernel.org>; Fri,  4 Oct 2024 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728059744; cv=none; b=oLZe25sfEk6C4QLhSKgPWMDyE+kUP3wnN4JO8QDDKFo2IQohol0cDCadyzvv5PmVC/+lKbFCw8DaYREVgl0K/UAMsTahxkhC8IhrGnG19EHvSd9V0fMBdSLfzjCo4i9Qk4uliBfU21FaC6omel5DYFCC07mzVx1Xoz4EcVy/yV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728059744; c=relaxed/simple;
	bh=Rht8DS0KyZW4WkLs7S4Ooh3jDq7YzZ8jwWDHpGUOmJg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NnxuvBXsmd25kYBnMcK3QmtZMrI9YVPcRXn88HkCxDAAKxYV7FtJlvpcdA0QfVVCZfg2WXg1TzA+angeBfdzk7MuEnb3k6UqcJf9zrsr0BNOEPcGdtiTEbPeB5Q6vVVjFDtzwX6XeORREn5bpUe6kA/23W5FKPdGBg4SRgc8uZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zp6oolf/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zp6oolf/"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37ccf0c0376so1517886f8f.3
        for <linux-block@vger.kernel.org>; Fri, 04 Oct 2024 09:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728059741; x=1728664541; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IKELkdxiqxEeNokUkCM6G/0RoFcGikRuDSNexYJ+bZE=;
        b=Zp6oolf/erfZDUa+tT/HPWzz81pbEqFyd9/DxwFwCTNX3iyxvOi4a3unhb3HJsBobd
         aK8qS3RIgxXa2PSFCX2ofznJB/cj7CIVkZQt0XMLtcnmbHVGW2kiwOi7A06hfTsj8kj4
         H3ZFvrUkI9l9tsCrWJ3ln/EwI8qmCFjYyicKk9g6sHQjMc4AAdfhDh4FOrJEa5NXlRBf
         YUGkrRYtzGAlom6BMF5Ce6PuU6fJUAxFolN51CeScev/4TjOWUYec3/uOc1YpVEFETWd
         wxb+Fa4acbwWxEiznhkMmxOYGxUBrWcNmmH/DaytPg43fx9QVGBO8ZVjnO68rfrM43QC
         en4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728059741; x=1728664541;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKELkdxiqxEeNokUkCM6G/0RoFcGikRuDSNexYJ+bZE=;
        b=DLsbraB2WKCpYrjPhFZcovplOgAZZRtJ8DkDDfOMVQ/nygagjTn/NqV/tZCQ7ejDKm
         khybHCnq6rlnOxM4p9iKx20oThgdrxJSrl0vjQjK6ralvcHSEHVvpQv2Eo/CTIzfq63O
         YiZEC3eI2s+VjDLbGG3YtrKYAK0j8xe4mDk0/Sv3/5slApRRWEX/wyN+SfE8WV/0IJD4
         vVmQlj4vZtAvI38BM0mEYCGzNFtO06JYcC3HHHROITxS43v+wkRnL1pg0mkmVDrJ1qfY
         uVCi7U7+5MSw3dpKitWL85DUOCk2zFYrgoJP7YLdFrTloK4FHGWABQjnEGifCVtp64fM
         koJg==
X-Gm-Message-State: AOJu0Yy9qfZm6UX4Vf9QORJ37OfLLuhxkq9pfKtax4G6DQ9naHuosSxX
	5rrQd40AjZtxMil+xFx0iBm/A/lXN1gmoO0oknHV9ixXbBVp9BrDaJbl20N0S1A=
X-Google-Smtp-Source: AGHT+IEEY3IQ6Vkgb5y0joo/8LRBEVQYumMIaqnCSTLDtG7bZzgRKWblFPLn9vPTYW8JxaIm/W79Wg==
X-Received: by 2002:a5d:6e91:0:b0:37c:d344:8b42 with SMTP id ffacd0b85a97d-37d0e6f0dfemr2192183f8f.15.1728059740605;
        Fri, 04 Oct 2024 09:35:40 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16972dfcsm24815f8f.102.2024.10.04.09.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 09:35:39 -0700 (PDT)
Date: Fri, 4 Oct 2024 19:35:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Guoqing Jiang <guoqing.jiang@linux.dev>
Cc: linux-block@vger.kernel.org
Subject: [bug report] rnbd-clt: open code send_msg_open in rnbd_clt_map_device
Message-ID: <bf9bc0a2-93e3-4def-b3ad-7a9d4c3f8c27@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Guoqing Jiang,

Commit 9ddae3bab6d7 ("rnbd-clt: open code send_msg_open in
rnbd_clt_map_device") from Jul 6, 2022 (linux-next), leads to the
following Smatch static checker warning:

	drivers/block/rnbd/rnbd-clt.c:1641 rnbd_clt_map_device()
	warn: double destroy '&dev->lock' (orig line 1589)

drivers/block/rnbd/rnbd-clt.c
    1527 struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
    1528                                            struct rtrs_addr *paths,
    1529                                            size_t path_cnt, u16 port_nr,
    1530                                            const char *pathname,
    1531                                            enum rnbd_access_mode access_mode,
    1532                                            u32 nr_poll_queues)
    1533 {
    1534         struct rnbd_clt_session *sess;
    1535         struct rnbd_clt_dev *dev;
    1536         int ret, errno;
    1537         struct rnbd_msg_open_rsp *rsp;
    1538         struct rnbd_msg_open msg;
    1539         struct rnbd_iu *iu;
    1540         struct kvec vec = {
    1541                 .iov_base = &msg,
    1542                 .iov_len  = sizeof(msg)
    1543         };
    1544 
    1545         if (exists_devpath(pathname, sessname))
    1546                 return ERR_PTR(-EEXIST);
    1547 
    1548         sess = find_and_get_or_create_sess(sessname, paths, path_cnt, port_nr, nr_poll_queues);
    1549         if (IS_ERR(sess))
    1550                 return ERR_CAST(sess);
    1551 
    1552         dev = init_dev(sess, access_mode, pathname, nr_poll_queues);
    1553         if (IS_ERR(dev)) {
    1554                 pr_err("map_device: failed to map device '%s' from session %s, can't initialize device, err: %pe\n",
    1555                        pathname, sess->sessname, dev);
    1556                 ret = PTR_ERR(dev);
    1557                 goto put_sess;
    1558         }
    1559         if (insert_dev_if_not_exists_devpath(dev)) {
    1560                 ret = -EEXIST;
    1561                 goto put_dev;

Should these error paths really call rnbd_clt_put_dev()?

    1562         }
    1563 
    1564         rsp = kzalloc(sizeof(*rsp), GFP_KERNEL);
    1565         if (!rsp) {
    1566                 ret = -ENOMEM;
    1567                 goto del_dev;
    1568         }
    1569 
    1570         iu = rnbd_get_iu(sess, RTRS_ADMIN_CON, RTRS_PERMIT_WAIT);
    1571         if (!iu) {
    1572                 ret = -ENOMEM;
    1573                 kfree(rsp);
    1574                 goto del_dev;
    1575         }
    1576         iu->buf = rsp;
    1577         iu->dev = dev;
    1578         sg_init_one(iu->sgt.sgl, rsp, sizeof(*rsp));
    1579 
    1580         msg.hdr.type    = cpu_to_le16(RNBD_MSG_OPEN);
    1581         msg.access_mode = dev->access_mode;
    1582         strscpy(msg.dev_name, dev->pathname, sizeof(msg.dev_name));
    1583 
    1584         WARN_ON(!rnbd_clt_get_dev(dev));

The patch copied the rnbd_clt_get_dev() send_msg_open() to here.  Why do we
need to take a second reference?  The gotos above imply that we are already
holding a reference.

    1585         ret = send_usr_msg(sess->rtrs, READ, iu,
    1586                            &vec, sizeof(*rsp), iu->sgt.sgl, 1,
    1587                            msg_open_conf, &errno, RTRS_PERMIT_WAIT);
    1588         if (ret) {
    1589                 rnbd_clt_put_dev(dev);
    1590                 rnbd_put_iu(sess, iu);

And these two puts.  Originally this failure path used to do a goto del_dev but
commit commit 52334f4a573d ("rnbd-clt: don't free rsp in msg_open_conf for map
scenario") changed it to goto put_iu so rnbd_put_iu() is called twice.

    1591         } else {
    1592                 ret = errno;
    1593         }
    1594         if (ret) {
    1595                 rnbd_clt_err(dev,
    1596                               "map_device: failed, can't open remote device, err: %d\n",
    1597                               ret);
    1598                 goto put_iu;
                         ^^^^^^^^^^^^
This goto here.

    1599         }
    1600         mutex_lock(&dev->lock);
    1601         pr_debug("Opened remote device: session=%s, path='%s'\n",
    1602                  sess->sessname, pathname);
    1603         ret = rnbd_client_setup_device(dev, rsp);
    1604         if (ret) {
    1605                 rnbd_clt_err(dev,
    1606                               "map_device: Failed to configure device, err: %d\n",
    1607                               ret);
    1608                 mutex_unlock(&dev->lock);
    1609                 goto send_close;
    1610         }
    1611 
    1612         rnbd_clt_info(dev,
    1613                        "map_device: Device mapped as %s (nsectors: %llu, logical_block_size: %d, physical_block_size: %d, max_write_zeroes_sectors: %d, max_discard_sectors: %d, discard_granularity: %d, discard_alignment: %d, secure_discard: %d, max_segments: %d, max_hw_sectors: %d, wc: %d, fua: %d)\n",
    1614                        dev->gd->disk_name, le64_to_cpu(rsp->nsectors),
    1615                        le16_to_cpu(rsp->logical_block_size),
    1616                        le16_to_cpu(rsp->physical_block_size),
    1617                        le32_to_cpu(rsp->max_write_zeroes_sectors),
    1618                        le32_to_cpu(rsp->max_discard_sectors),
    1619                        le32_to_cpu(rsp->discard_granularity),
    1620                        le32_to_cpu(rsp->discard_alignment),
    1621                        le16_to_cpu(rsp->secure_discard),
    1622                        sess->max_segments, sess->max_io_size / SECTOR_SIZE,
    1623                        !!(rsp->cache_policy & RNBD_WRITEBACK),
    1624                        !!(rsp->cache_policy & RNBD_FUA));
    1625 
    1626         mutex_unlock(&dev->lock);
    1627         kfree(rsp);
    1628         rnbd_put_iu(sess, iu);
    1629         rnbd_clt_put_sess(sess);
    1630 
    1631         return dev;
    1632 
    1633 send_close:
    1634         send_msg_close(dev, dev->device_id, RTRS_PERMIT_WAIT);
    1635 put_iu:
    1636         kfree(rsp);
    1637         rnbd_put_iu(sess, iu);
                 ^^^^^^^^^^^^^^^^^^^^^
    1638 del_dev:
    1639         delete_dev(dev);
    1640 put_dev:
--> 1641         rnbd_clt_put_dev(dev);
                 ^^^^^^^^^^^^^^^^^^^^^
    1642 put_sess:
    1643         rnbd_clt_put_sess(sess);
    1644 
    1645         return ERR_PTR(ret);
    1646 }

regards,
dan carpenter
