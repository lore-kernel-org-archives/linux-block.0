Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:46718 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932217AbdGJOJh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2017 10:09:37 -0400
Date: Mon, 10 Jul 2017 17:09:22 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: hch@lst.de
Cc: Boaz Harrosh <ooo@electrozaur.com>, linux-block@vger.kernel.org
Subject: [bug report] block: introduce new block status code type
Message-ID: <20170710140922.pjqyxfiaiczihyic@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Christoph Hellwig,

The patch 2a842acab109: "block: introduce new block status code type"
from Jun 3, 2017, leads to the following static checker warning:

	fs/exofs/inode.c:1333 exofs_new_inode()
	error: passing non negative 255 to ERR_PTR

drivers/scsi/osd/osd_initiator.c
  1909  analyze:
  1910          if (!osi->key) {
  1911                  /* scsi sense is Empty, the request was never issued to target
  1912                   * linux return code might tell us what happened.
  1913                   */
  1914                  if (or->async_error == BLK_STS_RESOURCE)
  1915                          osi->osd_err_pri = OSD_ERR_PRI_RESOURCE;
  1916                  else
  1917                          osi->osd_err_pri = OSD_ERR_PRI_UNREACHABLE;
  1918                  ret = or->async_error;
                        ^^^^^^^^^^^^^^^^^^^^^
The problem is that we're mixing the new block codes and normal kernel
error codes.  It's disapointing that Sparse doesn't seem to complain
about this assignment.  Anyway, we propagate the error code back and
eventually pass it through ERR_PTR() and IS_ERR() and then dereference
it.

  1919          } else if (osi->key <= scsi_sk_recovered_error) {
  1920                  osi->osd_err_pri = 0;
  1921                  ret = 0;
  1922          } else if (osi->additional_code == scsi_invalid_field_in_cdb) {
  1923                  if (osi->cdb_field_offset == OSD_CFO_STARTING_BYTE) {
  1924                          osi->osd_err_pri = OSD_ERR_PRI_CLEAR_PAGES;
  1925                          ret = -EFAULT; /* caller should recover from this */
  1926                  } else if (osi->cdb_field_offset == OSD_CFO_OBJECT_ID) {
  1927                          osi->osd_err_pri = OSD_ERR_PRI_NOT_FOUND;
  1928                          ret = -ENOENT;
  1929                  } else if (osi->cdb_field_offset == OSD_CFO_PERMISSIONS) {
  1930                          osi->osd_err_pri = OSD_ERR_PRI_NO_ACCESS;
  1931                          ret = -EACCES;
  1932                  } else {
  1933                          osi->osd_err_pri = OSD_ERR_PRI_BAD_CRED;
  1934                          ret = -EINVAL;
  1935                  }
  1936          } else if (osi->additional_code == osd_quota_error) {
  1937                  osi->osd_err_pri = OSD_ERR_PRI_NO_SPACE;
  1938                  ret = -ENOSPC;
  1939          } else if (_is_osd_security_code(osi->additional_code)) {
  1940                  osi->osd_err_pri = OSD_ERR_PRI_BAD_CRED;
  1941                  ret = -EINVAL;
  1942          } else {

regards,
dan carpenter
